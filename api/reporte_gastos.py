"""
Vercel Serverless Function — Reporte de Gastos

GET /api/reporte_gastos
Devuelve un resumen agregado de los gastos vigentes (no anulados)
agrupados por categoría.

Variables de entorno requeridas:
  - SUPABASE_URL
  - SUPABASE_SERVICE_ROLE_KEY  (bypassa RLS — solo backend)
"""
from http.server import BaseHTTPRequestHandler
from datetime import datetime, timezone
import json
import os

from supabase import create_client


class handler(BaseHTTPRequestHandler):
    def do_GET(self) -> None:
        try:
            url = os.environ.get('SUPABASE_URL')
            key = os.environ.get('SUPABASE_SERVICE_ROLE_KEY')

            if not url or not key:
                return self._json(500, {
                    'error': 'config_missing',
                    'message': 'Faltan SUPABASE_URL o SUPABASE_SERVICE_ROLE_KEY en el entorno.',
                })

            sb = create_client(url, key)

            res = (
                sb.table('gastos')
                .select('id, monto, fecha, categoria_gasto_id, categorias_gasto(nombre)')
                .is_('deleted_at', 'null')
                .execute()
            )

            rows = res.data or []
            total = 0.0
            por_categoria: dict[str, dict[str, float]] = {}

            for r in rows:
                cat_obj = r.get('categorias_gasto') or {}
                nombre = cat_obj.get('nombre') or 'SIN CLASIFICAR'
                monto = float(r.get('monto') or 0)
                total += monto
                bucket = por_categoria.setdefault(nombre, {'total': 0.0, 'cantidad': 0})
                bucket['total'] += monto
                bucket['cantidad'] += 1

            por_categoria_list = sorted(
                [
                    {
                        'categoria': nombre,
                        'total': round(b['total'], 2),
                        'cantidad': int(b['cantidad']),
                    }
                    for nombre, b in por_categoria.items()
                ],
                key=lambda x: -x['total'],
            )

            self._json(200, {
                'cantidad_registros': len(rows),
                'total_gastos': round(total, 2),
                'por_categoria': por_categoria_list,
                'generado_en': datetime.now(timezone.utc).isoformat(),
            })
        except Exception as e:
            self._json(500, {
                'error': type(e).__name__,
                'message': str(e),
            })

    def _json(self, code: int, payload: dict) -> None:
        body = json.dumps(payload, ensure_ascii=False)
        self.send_response(code)
        self.send_header('Content-Type', 'application/json; charset=utf-8')
        self.send_header('Cache-Control', 'no-store')
        self.send_header('Access-Control-Allow-Origin', '*')
        self.end_headers()
        self.wfile.write(body.encode('utf-8'))

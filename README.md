# Sistema Cooperativa Primero de Mayo

🌎 **English** · [Español](README.es.md)

An enterprise-grade ERP and financial management system built for municipal markets and cooperative associations to manage retail spaces, utilities distribution, membership accounts, and cash desks.

[![Live Demo](https://img.shields.io/badge/demo-live-success?style=for-the-badge&logo=vercel)](https://sistema-cooperativa-ochre.vercel.app)
[![Angular](https://img.shields.io/badge/Angular-20-DD0031?style=for-the-badge&logo=angular)](https://angular.dev)
[![Supabase](https://img.shields.io/badge/Supabase-Database-3ECF8E?style=for-the-badge&logo=supabase)](https://supabase.com)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind--v4-38B2AC?style=for-the-badge&logo=tailwind-css)](https://tailwindcss.com)

A specialized management platform designed for the Primero de Mayo Cooperative Market. It provides administrative boards and cashiers with a secure, ACID-compliant tool to manage retail spaces, distribute communal water and electricity expenses, bill fixed membership fees, and record cash and card collections with audit trails. 

---

## 🏗️ Architecture & Flow Overview

```mermaid
graph TD
    A[Public Portal / consultations] -->|DNI / Puesto Search| B[Edge Routing / Vercel]
    C[Admin Panel / Angular 20] -->|HTTPS / JWT Auth| B
    B -->|PostGREST API / SSL| D[(Supabase Postgres)]
    D -->|Row-Level Security Policies| E[Tables & Views]
    D -->|ACID Stored Procedures / Triggers| F[Transaction Processor]
    D -->|Audit System| G[Auditoría Log]
```

---

## 🛠️ Tech Stack

*   **Frontend Core**: Angular 20 (Standalone Components, Reactive Signals state management, Lazy Loading routing).
*   **Styling & Design System**: Tailwind CSS v4.0 (harmonic palettes, Outfit typography, custom dark mode, custom TailAdmin layout).
*   **Database & Backend-as-a-Service**: Supabase Postgres v15+ (PostGREST API exposed via JWT authentication, Stored Procedures, Triggers, RLS policies).
*   **Libraries**:
    *   `@supabase/supabase-js` - Realtime data fetching and Auth.
    *   `pdfmake` - High-quality PDF receipt and report generation (80mm thermal tickets & A4).
    *   `xlsx` (SheetJS) - Multi-sheet Excel exports, loaded lazily via dynamic `import()` (also used by data-migration scripts).
    *   `apexcharts` & `ng-apexcharts` - Visual financial analytics (installed, pending adoption).
    *   `flatpickr` - Ergonomic dates and periods selector.

---

## 🚀 Key Features

*   **Dual-Perspective Directory**: Manages hierarchical occupancies distinguishing between main commercial Spaces (Regular/Small stalls) and secondary storage Units (Almacenes) assigned to Partners, Tenants, or Third-parties.
*   **Granular Utility Distribution**: Calculates monthly Water and Electricity billing based on physical meter readings or flat-rate sharing, featuring toggles to instantly suspend billing on disabled stalls.
*   **Partnership Account Settings**: Restricts corporate fees (GA - *Gastos Administrativos* & PS - *Previsión Social*) exclusively to active Partners with toggle switches to suspend charges individually.
*   **Unified Account Statement**: Tracks the complete financial lifecycle of each stall under a double-entry ledger, automatically recalculating reactive balances (*Saldo a Favor*) on payments.
*   **Double-Entry POS & Card Processing**: POS interface (*Caja Rápida*) for cashiers supporting credit card receipts (Visa/Mastercard), daily cash desk balances (*Arqueo de Caja*), and automated payment applications via transactional RPCs.
*   **Single Source of Debt Truth**: One canonical SQL function (`fn_deudas_pagador`) feeds the Cash Desk, Account Statements, the Members Directory and the Public Portal, guaranteeing every screen shows exactly the same consolidated balance (main stall + warehouses + personal charges).
*   **Drill-Down Reporting & Excel Export**: Server-side aggregated reports (immune to PostgREST row limits) with expandable per-concept detail down to individual receipt lines, payer-type filters, and clean 4-sheet Excel workbooks.
*   **Masked Public Search**: A secure public portal where users can query pending debts using their DNI or Stall Number, with DNI masking and brute-force mitigation.
*   **Narrative Audit Timeline**: An immutable, admin-only activity log rendered as a human-readable timeline (actor + role, resolved entity names, before ➔ after field diffs, and transaction-scoped *reasons* for sensitive changes).
*   **Member Benefits Ledger**: Registry of diets (assembly attendance) and social-provision aid payments per member, with yearly grouped reporting.

---

## ⚙️ Getting Started

### Prerequisites
*   Node.js 18.x or 20.x (recommended)
*   Angular CLI installed globally:
    ```bash
    npm install -g @angular/cli
    ```

### 1. Clone the Repository
```bash
git clone https://github.com/omparedes/SistemaCooperativa.git
cd SistemaCooperativa
```

### 2. Configure Environment Variables
Create a `.env` file in the root folder with your Supabase credentials:
```ini
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-public-key
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key-never-expose
```

### 3. Install Dependencies
```bash
npm install
```

### 4. Run Locally
Start the development server:
```bash
npm start
```
Open **[http://localhost:4200](http://localhost:4200)** in your browser.

---

## 📋 Environment Variables

| Variable Name | Description | Required | Scope / Security |
| :--- | :--- | :---: | :--- |
| `SUPABASE_URL` | The REST API endpoint of your Supabase Postgres cluster | **Yes** | Client & Server |
| `SUPABASE_ANON_KEY` | Public anonymous key to perform basic read/write operations under RLS guards | **Yes** | Client & Server |
| `SUPABASE_SERVICE_ROLE_KEY` | Private admin key that bypasses RLS policies (used ONLY in migration and seed scripts) | **Yes** | Server-Only (Secret) |
| `SUPABASE_PROJECT_REF` | Ref ID of your remote project (used by Supabase CLI commands) | No | Development / CLI |
| `SUPABASE_DB_PASSWORD` | DB Password for local/remote database connections | No | Development / CLI |

---

## 📂 Project Structure

```bash
SistemaCooperativa/
├── src/
│   ├── app/
│   │   ├── core/                  # Singleton architecture services, guards, and models
│   │   │   ├── guards/            # Route guards (authGuard, adminGuard)
│   │   │   └── services/          # Services for API connection (socios, giros, pagos, bancos)
│   │   ├── pages/                 # Standalone page components mapped to lazy routes
│   │   │   ├── socios/            # Partners, Tenants and profiles management
│   │   │   ├── espacios/          # Stalls & warehouse occupancies, transfers
│   │   │   ├── giros/             # Commercial activity categories CRUD
│   │   │   ├── pagos/             # Payment POS wizard, rapid cash, card collection
│   │   │   ├── facturacion/       # Communal expense sharing, Luz and Agua medidores
│   │   │   ├── cuenta-corriente/  # Account statements and ledgers
│   │   │   ├── reportes/          # Drill-down reports, Excel export, daily cash closeout
│   │   │   ├── auditoria/         # Narrative audit timeline (admin-only)
│   │   │   ├── config/            # Tariffs and receipt-design settings
│   │   │   ├── usuarios/          # User & role management (admin-only)
│   │   │   └── consultas/         # Secure public search directory
│   │   ├── shared/                # Layouts (app-layout, app-sidebar) and components
│   │   └── app.routes.ts          # Central routing registry with Lazy Loaded chunks
│   └── styles.css                 # Global CSS importing Tailwind CSS v4 directives
├── supabase/
│   ├── migrations/                # Database migrations (Postgres schema, RLS, RPC functions)
│   └── config.toml                # Supabase project configuration
├── scripts/                       # Data-migration generators & diagnostic SQL
├── AUDITORIA_2026.md              # Functional audit report (module-by-module health)
├── ARCHITECTURE.md                # Architecture Decision Records
├── CONTEXT.md · CLAUDE.md         # Business context & AI/developer working rules
├── TODO.md                        # Prioritized backlog
├── package.json                   # Dependencies and scripts definitions
└── README.md                      # Project documentation
```

---

## 🚧 Roadmap & Known Limitations

The prioritized backlog lives in [TODO.md](TODO.md) (derived from the July 2026 functional audit — see [AUDITORIA_2026.md](AUDITORIA_2026.md)). Highlights:

*   **Payment Concurrency Hardening**: `rpc_procesar_pago` will gain row-level locking (`FOR UPDATE`) and balance revalidation to prevent double-application when two cashiers charge the same member simultaneously.
*   **Benefits ↔ Cash Desk Integration**: Diet and social-provision payouts are recorded but do not yet flow through the physical cash drawer (arqueo) or expense reports.
*   **Local PDF Storage**: Generated PDFs are compiled client-side with `pdfmake`. Storage in Supabase Buckets with email delivery remains under development.
*   **Offline Transaction Buffer**: Cashier transactions require an active connection to Supabase; IndexedDB buffering for internet drops is planned.
*   **Bank Conciliation Automation**: Bank statement ingestion is still a manual flat-file process.

---

## 📄 License

This project is private and proprietary. All rights reserved. Developed by **[Oscar Paredes](https://github.com/omparedes)**.

*   **LinkedIn**: [linkedin.com/in/omparedes](https://linkedin.com/in/omparedes)
*   **GitHub**: [@omparedes](https://github.com/omparedes)

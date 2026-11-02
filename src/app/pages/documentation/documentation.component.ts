import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { APP_VERSION_DATA } from '../../core/config/version.config';

@Component({
    selector: 'app-documentation',
    standalone: true,
    imports: [CommonModule],
    templateUrl: './documentation.component.html',
})
export class DocumentationComponent {
    readonly versionData = APP_VERSION_DATA;
}

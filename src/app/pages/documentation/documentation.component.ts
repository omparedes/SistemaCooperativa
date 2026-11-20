import { Component, ChangeDetectionStrategy } from '@angular/core';

import { APP_VERSION_DATA } from '../../core/config/version.config';

@Component({
    selector: 'app-documentation',
    standalone: true,
    imports: [],
    changeDetection: ChangeDetectionStrategy.Eager,
    templateUrl: './documentation.component.html',
})
export class DocumentationComponent {
    readonly versionData = APP_VERSION_DATA;
}

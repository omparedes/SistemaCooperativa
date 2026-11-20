import { Component, ChangeDetectionStrategy } from '@angular/core';

import { APP_VERSION_DATA } from '../../core/config/version.config';

@Component({
    selector: 'app-user-manual',
    standalone: true,
    imports: [],
    changeDetection: ChangeDetectionStrategy.Eager,
    templateUrl: './user-manual.component.html',
})
export class UserManualComponent {
    readonly versionData = APP_VERSION_DATA;
}

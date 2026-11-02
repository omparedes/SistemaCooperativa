import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { APP_VERSION_DATA } from '../../core/config/version.config';

@Component({
    selector: 'app-user-manual',
    standalone: true,
    imports: [CommonModule],
    templateUrl: './user-manual.component.html',
})
export class UserManualComponent {
    readonly versionData = APP_VERSION_DATA;
}

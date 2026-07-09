//
//  PermissionSettings.swift
//  SamuraiPermissionFlow
//
//  Created by Ksyuleg on 09.07.2026.
//

#if os(iOS)

import UIKit

/// Opens the host app's Settings screen.
///
/// README note:
/// Use this after receiving `.denied` or `.restricted`,
/// because iOS usually does not show the system permission alert again
/// after the user has denied access.
public enum PermissionSettings {

    @MainActor
    public static func open() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }

        guard UIApplication.shared.canOpenURL(url) else { return }

        UIApplication.shared.open(url)
    }
}

#endif

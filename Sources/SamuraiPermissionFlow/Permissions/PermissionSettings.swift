//
//  PermissionSettings.swift
//  SamuraiPermissionFlow
//
//  Created by Ksyuleg on 09.07.2026.
//

#if os(iOS)

import UIKit

public enum PermissionSettings {

    @MainActor
    public static func open() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }

        guard UIApplication.shared.canOpenURL(url) else { return }

        UIApplication.shared.open(url)
    }
}

#endif

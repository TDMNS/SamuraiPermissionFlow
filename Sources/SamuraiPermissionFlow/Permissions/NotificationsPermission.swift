//
//  NotificationsPermission.swift
//  SamuraiPermissionFlow
//
//  Created by Ksyuleg on 09.07.2026.
//

#if os(iOS)

import UserNotifications

public struct NotificationsPermission: PermissionProvider {

    public init() {}

    public var status: PermissionStatus {
        get async {
            let settings = await UNUserNotificationCenter.current().notificationSettings()
            let permissionStatus = Self.mapStatus(settings.authorizationStatus)
            return permissionStatus
        }
    }

    public func request() async -> PermissionStatus {
        let currentSettings = await UNUserNotificationCenter.current().notificationSettings()

        switch currentSettings.authorizationStatus {
        case .authorized, .provisional, .ephemeral:
            return .authorized
        case .denied:
            return .denied
        case .notDetermined:
            do {
                let granted = try await UNUserNotificationCenter.current().requestAuthorization(
                    options: [.alert, .badge, .sound]
                )
                return granted ? .authorized : .denied
            } catch {
                return .denied
            }
        @unknown default:
            return .denied
        }
    }

    private static func mapStatus(_ status: UNAuthorizationStatus) -> PermissionStatus {
        switch status {
        case .notDetermined:
            return .notDetermined
        case .denied:
            return .denied
        case .authorized:
            return .authorized
        case .provisional:
            return .authorized
        case .ephemeral:
            return .authorized
        @unknown default:
            return .denied
        }
    }
}

#endif

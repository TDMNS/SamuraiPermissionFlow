//
//  LocationPermission.swift
//  SamuraiPermissionFlow
//
//  Created by Ksyuleg on 10.07.2026.
//

#if os(iOS)

import CoreLocation
import Foundation

/// Handles "When In Use" location permission.
///
/// README note:
/// To request location permission, the host app must include
/// `NSLocationWhenInUseUsageDescription` in its Info.plist.
/// Without this key, iOS may terminate the app when requesting authorization.
public struct LocationPermission: PermissionProvider {

    public init() {}

    public var status: PermissionStatus {
        get async {
            await Self.currentStatus()
        }
    }

    public func request() async -> PermissionStatus {
        let currentStatus = await Self.currentStatus()

        if currentStatus == .notDetermined {
            return await LocationPermissionRequester.requestWhenInUse()
        }

        return currentStatus
    }

    @MainActor
    private static func currentStatus() -> PermissionStatus {
        let manager = CLLocationManager()
        return mapStatus(manager.authorizationStatus)
    }

    internal static func mapStatus(_ status: CLAuthorizationStatus) -> PermissionStatus {
        switch status {
        case .notDetermined:
            return .notDetermined
        case .restricted:
            return .restricted
        case .denied:
            return .denied
        case .authorizedAlways, .authorizedWhenInUse:
            return .authorized
        @unknown default:
            return .denied
        }
    }
}

#endif

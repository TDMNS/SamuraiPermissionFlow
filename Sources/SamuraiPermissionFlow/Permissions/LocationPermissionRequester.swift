//
//  LocationPermissionRequester.swift
//  SamuraiPermissionFlow
//
//  Created by Ksyuleg on 10.07.2026.
//

#if os(iOS)

import CoreLocation
import Foundation

/// Internal helper that bridges `CLLocationManagerDelegate` callbacks
/// to async/await for "When In Use" location permission requests.
final class LocationPermissionRequester: NSObject, CLLocationManagerDelegate {

    private static var activeRequester: LocationPermissionRequester?

    private let manager: CLLocationManager
    private var continuation: CheckedContinuation<PermissionStatus, Never>?

    private override init() {
        self.manager = CLLocationManager()
        super.init()
        self.manager.delegate = self
    }

    static func requestWhenInUse() async -> PermissionStatus {
        let requester = LocationPermissionRequester()
        activeRequester = requester

        return await withCheckedContinuation { continuation in
            requester.continuation = continuation
            requester.manager.requestWhenInUseAuthorization()
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus

        guard status != .notDetermined else { return }

        continuation?.resume(
            returning: Self.mapStatus(status)
        )

        continuation = nil
        Self.activeRequester = nil
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

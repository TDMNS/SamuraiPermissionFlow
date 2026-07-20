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
@MainActor
final class LocationPermissionRequester: NSObject, CLLocationManagerDelegate {

    private static var activeRequester: LocationPermissionRequester?

    private let manager: CLLocationManager
    private var continuations: [CheckedContinuation<PermissionStatus, Never>] = []

    private override init() {
        self.manager = CLLocationManager()
        super.init()
        self.manager.delegate = self
    }

    static func requestWhenInUse() async -> PermissionStatus {
        let requester: LocationPermissionRequester

        if let activeRequester {
            requester = activeRequester
        } else {
            requester = LocationPermissionRequester()
            activeRequester = requester
        }

        return await withCheckedContinuation { continuation in
            let shouldStartRequest = requester.continuations.isEmpty
            requester.continuations.append(continuation)

            if shouldStartRequest {
                requester.manager.requestWhenInUseAuthorization()
            }
        }
    }

    nonisolated func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        Task { @MainActor [weak self] in
            self?.completeRequestIfNeeded()
        }
    }

    private func completeRequestIfNeeded() {
        let status = manager.authorizationStatus

        guard status != .notDetermined else { return }
        guard !continuations.isEmpty else { return }

        let pendingContinuations = continuations
        continuations.removeAll()

        if Self.activeRequester === self {
            Self.activeRequester = nil
        }

        let permissionStatus = Self.mapStatus(status)
        pendingContinuations.forEach { continuation in
            continuation.resume(returning: permissionStatus)
        }
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

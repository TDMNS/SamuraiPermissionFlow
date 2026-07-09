//
//  CameraPermission.swift
//  SamuraiPermissionFlow
//
//  Created by Ksyuleg on 09.07.2026.
//

import AVFoundation

/// Handles camera permission.
///
/// README note:
/// To request camera permission, the host app must include
/// `NSCameraUsageDescription` in its Info.plist.
public struct CameraPermission: PermissionProvider {

    public init() {}

    public var status: PermissionStatus {
        get async {
            Self.mapStatus(
                AVCaptureDevice.authorizationStatus(for: .video)
            )
        }
    }

    public func request() async -> PermissionStatus {
        let currentStatus = AVCaptureDevice.authorizationStatus(for: .video)

        switch currentStatus {
        case .authorized:
            return .authorized
        case .denied:
            return .denied
        case .restricted:
            return .restricted
        case .notDetermined:
            let granted = await AVCaptureDevice.requestAccess(for: .video)
            return granted ? .authorized : .denied
        @unknown default:
            return .denied
        }
    }

    internal static func mapStatus(_ status: AVAuthorizationStatus) -> PermissionStatus {
        switch status {
        case .notDetermined:
            return .notDetermined
        case .restricted:
            return .restricted
        case .denied:
            return .denied
        case .authorized:
            return .authorized
        @unknown default:
            return .denied
        }
    }
}

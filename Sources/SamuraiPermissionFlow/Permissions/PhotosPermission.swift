//
//  PhotosPermission.swift
//  SamuraiPermissionFlow
//
//  Created by Ksyuleg on 09.07.2026.
//

#if os(iOS)

import Photos

/// Handles photo library permission.
///
/// README note:
/// To request photo library permission, the host app should include
/// `NSPhotoLibraryUsageDescription` in its Info.plist.
public struct PhotosPermission: PermissionProvider {

    public init() {}

    public var status: PermissionStatus {
        get async {
            let systemStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
            let permissionStatus = Self.mapStatus(systemStatus)
            return permissionStatus
        }
    }

    public func request() async -> PermissionStatus {
        let currentStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)

        switch currentStatus {
        case .authorized:
            return .authorized
        case .limited:
            return .limited
        case .denied:
            return .denied
        case .restricted:
            return .restricted
        case .notDetermined:
            let newStatus = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
            return Self.mapStatus(newStatus)
        @unknown default:
            return .denied
        }
    }

    internal static func mapStatus(_ status: PHAuthorizationStatus) -> PermissionStatus {
        switch status {
        case .notDetermined:
            return .notDetermined
        case .restricted:
            return .restricted
        case .denied:
            return .denied
        case .authorized:
            return .authorized
        case .limited:
            return .limited
        @unknown default:
            return .denied
        }
    }
}

#endif

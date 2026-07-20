//
//  SamuraiPermission.swift
//  SamuraiPermissionFlow
//
//  Created by Ksyuleg on 09.07.2026.
//

import Foundation

public enum SamuraiPermission {
    public static let camera = CameraPermission()

    #if os(iOS)
    public static let microphone = MicrophonePermission()
    public static let photos = PhotosPermission()
    public static let notifications = NotificationsPermission()
    public static let location = LocationPermission()

    public static func status(_ kind: PermissionKind) async -> PermissionStatus {
        switch kind {
        case .camera:
            return await camera.status
        case .microphone:
            return await microphone.status
        case .photos:
            return await photos.status
        case .notifications:
            return await notifications.status
        case .location:
            return await location.status
        }
    }

    public static func request(_ kind: PermissionKind) async -> PermissionStatus {
        switch kind {
        case .camera:
            return await camera.request()
        case .microphone:
            return await microphone.request()
        case .photos:
            return await photos.request()
        case .notifications:
            return await notifications.request()
        case .location:
            return await location.request()
        }
    }
    #endif
}

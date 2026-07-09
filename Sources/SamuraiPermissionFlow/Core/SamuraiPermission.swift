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
    #endif
}

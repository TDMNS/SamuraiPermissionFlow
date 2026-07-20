//
//  PermissionKind.swift
//  SamuraiPermissionFlow
//
//  Created by Ksyuleg on 20.07.2026.
//

public enum PermissionKind: Sendable, Equatable, CaseIterable {
    case camera
    case microphone
    case photos
    case notifications
    case location

    public var identifier: String {
        switch self {
        case .camera:
            "camera"
        case .microphone:
            "microphone"
        case .photos:
            "photos"
        case .notifications:
            "notifications"
        case .location:
            "location"
        }
    }

    public var title: String {
        switch self {
        case .camera:
            "Camera"
        case .microphone:
            "Microphone"
        case .photos:
            "Photos"
        case .notifications:
            "Notifications"
        case .location:
            "Location"
        }
    }
}

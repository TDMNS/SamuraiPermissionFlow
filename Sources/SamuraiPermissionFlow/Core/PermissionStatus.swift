//
//  PermissionStatus.swift
//  SamuraiPermissionFlow
//
//  Created by Ksyuleg on 09.07.2026.
//

import Foundation

public enum PermissionStatus: Equatable, Sendable, CustomStringConvertible {
    case notDetermined
    case authorized
    case denied
    case restricted
    case limited

    public var isGranted: Bool {
        self == .authorized || self == .limited
    }

    public var isDenied: Bool {
        self == .denied
    }

    public var isRestricted: Bool {
        self == .restricted
    }

    public var isNotDetermined: Bool {
        self == .notDetermined
    }

    public var isLimited: Bool {
        self == .limited
    }

    public var requiresSettings: Bool {
        self == .denied || self == .restricted
    }

    public var canRequest: Bool {
        self == .notDetermined
    }

    public var description: String {
        switch self {
        case .notDetermined:
            "notDetermined"
        case .authorized:
            "authorized"
        case .denied:
            "denied"
        case .restricted:
            "restricted"
        case .limited:
            "limited"
        }
    }
}

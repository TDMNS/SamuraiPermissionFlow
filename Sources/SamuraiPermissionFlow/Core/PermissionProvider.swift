//
//  PermissionProvider.swift
//  SamuraiPermissionFlow
//
//  Created by Ksyuleg on 09.07.2026.
//

import Foundation

public protocol PermissionProvider: Sendable {
    var status: PermissionStatus { get async }
    
    func request() async -> PermissionStatus
}

public extension PermissionProvider {
    func isGranted() async -> Bool {
        await status.isGranted
    }

    func requiresSettings() async -> Bool {
        await status.requiresSettings
    }
}

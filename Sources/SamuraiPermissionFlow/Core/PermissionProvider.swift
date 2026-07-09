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

//
//  PermissionKindTests.swift
//  SamuraiPermissionFlow
//
//  Created by Ksyuleg on 20.07.2026.
//

import XCTest
@testable import SamuraiPermissionFlow

final class PermissionKindTests: XCTestCase {

    func testAllCasesContainsEveryPermissionKind() {
        XCTAssertEqual(
            PermissionKind.allCases,
            [.camera, .microphone, .photos, .notifications, .location]
        )
    }

    func testIdentifiers() {
        XCTAssertEqual(PermissionKind.camera.identifier, "camera")
        XCTAssertEqual(PermissionKind.microphone.identifier, "microphone")
        XCTAssertEqual(PermissionKind.photos.identifier, "photos")
        XCTAssertEqual(PermissionKind.notifications.identifier, "notifications")
        XCTAssertEqual(PermissionKind.location.identifier, "location")
    }

    func testTitles() {
        XCTAssertEqual(PermissionKind.camera.title, "Camera")
        XCTAssertEqual(PermissionKind.microphone.title, "Microphone")
        XCTAssertEqual(PermissionKind.photos.title, "Photos")
        XCTAssertEqual(PermissionKind.notifications.title, "Notifications")
        XCTAssertEqual(PermissionKind.location.title, "Location")
    }
}

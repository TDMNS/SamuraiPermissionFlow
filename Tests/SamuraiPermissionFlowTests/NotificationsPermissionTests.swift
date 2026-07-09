//
//  NotificationsPermissionTests.swift
//  SamuraiPermissionFlow
//
//  Created by Ksyuleg on 10.07.2026.
//

#if os(iOS)

import UserNotifications
import XCTest
@testable import SamuraiPermissionFlow

final class NotificationsPermissionTests: XCTestCase {

    func testMapNotDeterminedStatus() {
        let status = NotificationsPermission.mapStatus(.notDetermined)

        XCTAssertEqual(status, .notDetermined)
    }

    func testMapDeniedStatus() {
        let status = NotificationsPermission.mapStatus(.denied)

        XCTAssertEqual(status, .denied)
    }

    func testMapAuthorizedStatus() {
        let status = NotificationsPermission.mapStatus(.authorized)

        XCTAssertEqual(status, .authorized)
    }

    func testMapProvisionalStatus() {
        let status = NotificationsPermission.mapStatus(.provisional)

        XCTAssertEqual(status, .authorized)
    }

    func testMapEphemeralStatus() {
        let status = NotificationsPermission.mapStatus(.ephemeral)

        XCTAssertEqual(status, .authorized)
    }
}

#endif

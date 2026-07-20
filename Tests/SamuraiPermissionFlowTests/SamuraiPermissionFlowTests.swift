//
//  SamuraiPermissionFlowTests.swift
//  SamuraiPermissionFlow
//
//  Created by Ksyuleg on 10.07.2026.
//

import XCTest
@testable import SamuraiPermissionFlow

final class SamuraiPermissionFlowTests: XCTestCase {

    func testPermissionStatusEquatable() {
        XCTAssertEqual(PermissionStatus.authorized, .authorized)
        XCTAssertNotEqual(PermissionStatus.authorized, .denied)
    }

    func testPermissionStatusIsGranted() {
        XCTAssertFalse(PermissionStatus.notDetermined.isGranted)
        XCTAssertTrue(PermissionStatus.authorized.isGranted)
        XCTAssertFalse(PermissionStatus.denied.isGranted)
        XCTAssertFalse(PermissionStatus.restricted.isGranted)
        XCTAssertTrue(PermissionStatus.limited.isGranted)
    }

    func testPermissionStatusIsDenied() {
        XCTAssertFalse(PermissionStatus.notDetermined.isDenied)
        XCTAssertFalse(PermissionStatus.authorized.isDenied)
        XCTAssertTrue(PermissionStatus.denied.isDenied)
        XCTAssertFalse(PermissionStatus.restricted.isDenied)
        XCTAssertFalse(PermissionStatus.limited.isDenied)
    }

    func testPermissionStatusIsRestricted() {
        XCTAssertFalse(PermissionStatus.notDetermined.isRestricted)
        XCTAssertFalse(PermissionStatus.authorized.isRestricted)
        XCTAssertFalse(PermissionStatus.denied.isRestricted)
        XCTAssertTrue(PermissionStatus.restricted.isRestricted)
        XCTAssertFalse(PermissionStatus.limited.isRestricted)
    }

    func testPermissionStatusIsNotDetermined() {
        XCTAssertTrue(PermissionStatus.notDetermined.isNotDetermined)
        XCTAssertFalse(PermissionStatus.authorized.isNotDetermined)
        XCTAssertFalse(PermissionStatus.denied.isNotDetermined)
        XCTAssertFalse(PermissionStatus.restricted.isNotDetermined)
        XCTAssertFalse(PermissionStatus.limited.isNotDetermined)
    }

    func testPermissionStatusIsLimited() {
        XCTAssertFalse(PermissionStatus.notDetermined.isLimited)
        XCTAssertFalse(PermissionStatus.authorized.isLimited)
        XCTAssertFalse(PermissionStatus.denied.isLimited)
        XCTAssertFalse(PermissionStatus.restricted.isLimited)
        XCTAssertTrue(PermissionStatus.limited.isLimited)
    }

    func testPermissionStatusRequiresSettings() {
        XCTAssertFalse(PermissionStatus.notDetermined.requiresSettings)
        XCTAssertFalse(PermissionStatus.authorized.requiresSettings)
        XCTAssertTrue(PermissionStatus.denied.requiresSettings)
        XCTAssertTrue(PermissionStatus.restricted.requiresSettings)
        XCTAssertFalse(PermissionStatus.limited.requiresSettings)
    }

    func testPermissionStatusCanRequest() {
        XCTAssertTrue(PermissionStatus.notDetermined.canRequest)
        XCTAssertFalse(PermissionStatus.authorized.canRequest)
        XCTAssertFalse(PermissionStatus.denied.canRequest)
        XCTAssertFalse(PermissionStatus.restricted.canRequest)
        XCTAssertFalse(PermissionStatus.limited.canRequest)
    }

    func testPermissionStatusDescription() {
        XCTAssertEqual(PermissionStatus.notDetermined.description, "notDetermined")
        XCTAssertEqual(PermissionStatus.authorized.description, "authorized")
        XCTAssertEqual(PermissionStatus.denied.description, "denied")
        XCTAssertEqual(PermissionStatus.restricted.description, "restricted")
        XCTAssertEqual(PermissionStatus.limited.description, "limited")
    }
}

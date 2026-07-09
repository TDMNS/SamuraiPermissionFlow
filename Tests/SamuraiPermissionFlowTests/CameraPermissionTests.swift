//
//  CameraPermissionTests.swift
//  SamuraiPermissionFlow
//
//  Created by Ksyuleg on 10.07.2026.
//

import AVFoundation
import XCTest
@testable import SamuraiPermissionFlow

final class CameraPermissionTests: XCTestCase {

    func testMapNotDeterminedStatus() {
        let status = CameraPermission.mapStatus(.notDetermined)

        XCTAssertEqual(status, .notDetermined)
    }

    func testMapRestrictedStatus() {
        let status = CameraPermission.mapStatus(.restricted)

        XCTAssertEqual(status, .restricted)
    }

    func testMapDeniedStatus() {
        let status = CameraPermission.mapStatus(.denied)

        XCTAssertEqual(status, .denied)
    }

    func testMapAuthorizedStatus() {
        let status = CameraPermission.mapStatus(.authorized)

        XCTAssertEqual(status, .authorized)
    }
}

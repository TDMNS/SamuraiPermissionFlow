//
//  LocationPermissionTests.swift
//  SamuraiPermissionFlow
//
//  Created by Ksyuleg on 10.07.2026.
//

#if os(iOS)

import CoreLocation
import XCTest
@testable import SamuraiPermissionFlow

final class LocationPermissionTests: XCTestCase {

    func testMapNotDeterminedStatus() {
        let status = LocationPermission.mapStatus(.notDetermined)

        XCTAssertEqual(status, .notDetermined)
    }

    func testMapRestrictedStatus() {
        let status = LocationPermission.mapStatus(.restricted)

        XCTAssertEqual(status, .restricted)
    }

    func testMapDeniedStatus() {
        let status = LocationPermission.mapStatus(.denied)

        XCTAssertEqual(status, .denied)
    }

    func testMapAuthorizedWhenInUseStatus() {
        let status = LocationPermission.mapStatus(.authorizedWhenInUse)

        XCTAssertEqual(status, .authorized)
    }

    func testMapAuthorizedAlwaysStatus() {
        let status = LocationPermission.mapStatus(.authorizedAlways)

        XCTAssertEqual(status, .authorized)
    }
}

#endif

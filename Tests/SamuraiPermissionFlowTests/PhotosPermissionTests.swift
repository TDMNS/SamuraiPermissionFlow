//
//  PhotosPermissionTests.swift
//  SamuraiPermissionFlow
//
//  Created by Ksyuleg on 10.07.2026.
//

#if os(iOS)

import Photos
import XCTest
@testable import SamuraiPermissionFlow

final class PhotosPermissionTests: XCTestCase {

    func testMapNotDeterminedStatus() {
        let status = PhotosPermission.mapStatus(.notDetermined)

        XCTAssertEqual(status, .notDetermined)
    }

    func testMapRestrictedStatus() {
        let status = PhotosPermission.mapStatus(.restricted)

        XCTAssertEqual(status, .restricted)
    }

    func testMapDeniedStatus() {
        let status = PhotosPermission.mapStatus(.denied)

        XCTAssertEqual(status, .denied)
    }

    func testMapAuthorizedStatus() {
        let status = PhotosPermission.mapStatus(.authorized)

        XCTAssertEqual(status, .authorized)
    }

    func testMapLimitedStatus() {
        let status = PhotosPermission.mapStatus(.limited)

        XCTAssertEqual(status, .limited)
    }
}

#endif

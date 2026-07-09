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
}

//
//  MicrophonePermissionTests.swift
//  SamuraiPermissionFlow
//
//  Created by Ksyuleg on 10.07.2026.
//

#if os(iOS)

import AVFoundation
import XCTest
@testable import SamuraiPermissionFlow

final class MicrophonePermissionTests: XCTestCase {

    func testMapUndeterminedStatus() {
        let status = MicrophonePermission.mapStatus(.undetermined)

        XCTAssertEqual(status, .notDetermined)
    }

    func testMapDeniedStatus() {
        let status = MicrophonePermission.mapStatus(.denied)

        XCTAssertEqual(status, .denied)
    }

    func testMapGrantedStatus() {
        let status = MicrophonePermission.mapStatus(.granted)

        XCTAssertEqual(status, .authorized)
    }
}

#endif

//
//  PermissionProviderTests.swift
//  SamuraiPermissionFlow
//
//  Created by Ksyuleg on 20.07.2026.
//

import XCTest
@testable import SamuraiPermissionFlow

final class PermissionProviderTests: XCTestCase {

    func testIsGrantedUsesCurrentStatus() async {
        let expectations: [(status: PermissionStatus, expected: Bool)] = [
            (.authorized, true),
            (.limited, true),
            (.denied, false),
            (.restricted, false),
            (.notDetermined, false),
        ]

        for expectation in expectations {
            let provider = MockPermissionProvider(status: expectation.status)
            let result = await provider.isGranted()

            XCTAssertEqual(result, expectation.expected, "Unexpected result for \(expectation.status)")
        }
    }

    func testRequiresSettingsUsesCurrentStatus() async {
        let expectations: [(status: PermissionStatus, expected: Bool)] = [
            (.denied, true),
            (.restricted, true),
            (.authorized, false),
            (.limited, false),
            (.notDetermined, false),
        ]

        for expectation in expectations {
            let provider = MockPermissionProvider(status: expectation.status)
            let result = await provider.requiresSettings()

            XCTAssertEqual(result, expectation.expected, "Unexpected result for \(expectation.status)")
        }
    }
}

private struct MockPermissionProvider: PermissionProvider {
    let status: PermissionStatus

    func request() async -> PermissionStatus {
        status
    }
}

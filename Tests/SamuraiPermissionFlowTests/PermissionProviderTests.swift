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
        let grantedProvider = MockPermissionProvider(status: .limited)
        let deniedProvider = MockPermissionProvider(status: .denied)
        let isGranted = await grantedProvider.isGranted()
        let isDeniedGranted = await deniedProvider.isGranted()

        XCTAssertTrue(isGranted)
        XCTAssertFalse(isDeniedGranted)
    }

    func testRequiresSettingsUsesCurrentStatus() async {
        let restrictedProvider = MockPermissionProvider(status: .restricted)
        let requestableProvider = MockPermissionProvider(status: .notDetermined)
        let requiresSettings = await restrictedProvider.requiresSettings()
        let requestableRequiresSettings = await requestableProvider.requiresSettings()

        XCTAssertTrue(requiresSettings)
        XCTAssertFalse(requestableRequiresSettings)
    }
}

private struct MockPermissionProvider: PermissionProvider {
    let status: PermissionStatus

    func request() async -> PermissionStatus {
        status
    }
}

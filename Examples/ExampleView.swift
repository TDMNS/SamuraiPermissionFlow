//
//  ExampleView.swift
//  SamuraiPermissionFlow
//
//  Created by Ksyuleg on 10.07.2026.
//

import SwiftUI
import SamuraiPermissionFlow

struct ExampleView: View {

    @State private var cameraStatus: PermissionStatus?
    @State private var microphoneStatus: PermissionStatus?
    @State private var photosStatus: PermissionStatus?
    @State private var notificationsStatus: PermissionStatus?
    @State private var locationStatus: PermissionStatus?

    var body: some View {
        NavigationStack {
            List {
                permissionRow(
                    title: "Camera",
                    status: cameraStatus
                ) {
                    cameraStatus = await SamuraiPermission.camera.request()
                }

                permissionRow(
                    title: "Microphone",
                    status: microphoneStatus
                ) {
                    microphoneStatus = await SamuraiPermission.microphone.request()
                }

                permissionRow(
                    title: "Photos",
                    status: photosStatus
                ) {
                    photosStatus = await SamuraiPermission.photos.request()
                }

                permissionRow(
                    title: "Notifications",
                    status: notificationsStatus
                ) {
                    notificationsStatus = await SamuraiPermission.notifications.request()
                }

                permissionRow(
                    title: "Location",
                    status: locationStatus
                ) {
                    locationStatus = await SamuraiPermission.location.request()
                }

                Section {
                    Button("Open Settings") {
                        Task {
                            await PermissionSettings.open()
                        }
                    }
                }
            }
            .navigationTitle("Permissions")
        }
    }

    private func permissionRow(
        title: String,
        status: PermissionStatus?,
        action: @escaping () async -> Void
    ) -> some View {
        Section {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)

                    Text(status?.title ?? "Not requested")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Button("Request") {
                    Task {
                        await action()
                    }
                }
            }
        }
    }
}

private extension PermissionStatus {

    var title: String {
        switch self {
        case .notDetermined:
            return "Not determined"

        case .authorized:
            return "Authorized"

        case .denied:
            return "Denied"

        case .restricted:
            return "Restricted"

        case .limited:
            return "Limited"
        }
    }
}

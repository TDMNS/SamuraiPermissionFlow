//
//  PermissionGate.swift
//  SamuraiPermissionFlow
//
//  Created by Ksyuleg on 20.07.2026.
//

#if os(iOS)

import SwiftUI

@MainActor
public struct PermissionGate<Content: View>: View {

    private let kind: PermissionKind
    private let requestOnAppear: Bool
    private let content: () -> Content
    private let requestView: (@escaping () -> Void) -> AnyView
    private let deniedView: (@escaping () -> Void) -> AnyView

    @State private var status: PermissionStatus?
    @State private var isRequesting = false
    @State private var didAttemptAutomaticRequest = false

    public init(
        _ kind: PermissionKind,
        requestOnAppear: Bool = false,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.kind = kind
        self.requestOnAppear = requestOnAppear
        self.content = content
        self.requestView = { action in
            AnyView(DefaultPermissionRequestView(kind: kind, action: action))
        }
        self.deniedView = { action in
            AnyView(DefaultPermissionDeniedView(kind: kind, action: action))
        }
    }

    public init<RequestContent: View, DeniedContent: View>(
        _ kind: PermissionKind,
        requestOnAppear: Bool = false,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder request: @escaping () -> RequestContent,
        @ViewBuilder denied: @escaping () -> DeniedContent
    ) {
        self.kind = kind
        self.requestOnAppear = requestOnAppear
        self.content = content
        self.requestView = { _ in AnyView(request()) }
        self.deniedView = { _ in AnyView(denied()) }
    }

    public var body: some View {
        Group {
            if let status {
                if status.isGranted {
                    content()
                } else if status.isNotDetermined {
                    requestView(requestPermission)
                } else if status.requiresSettings {
                    deniedView(PermissionSettings.open)
                }
            } else {
                ProgressView()
            }
        }
        .task {
            await refreshStatus()
        }
    }

    private func refreshStatus() async {
        let currentStatus = await SamuraiPermission.status(kind)
        status = currentStatus

        guard requestOnAppear else { return }
        guard currentStatus.canRequest else { return }
        guard !didAttemptAutomaticRequest else { return }

        didAttemptAutomaticRequest = true
        await performRequest()
    }

    private func requestPermission() {
        Task {
            await performRequest()
        }
    }

    private func performRequest() async {
        guard status?.canRequest == true else { return }
        guard !isRequesting else { return }

        isRequesting = true
        defer { isRequesting = false }

        status = await SamuraiPermission.request(kind)
    }
}

private struct DefaultPermissionRequestView: View {
    let kind: PermissionKind
    let action: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Text("\(kind.title) permission is required.")
                .multilineTextAlignment(.center)

            Button("Request", action: action)
                .buttonStyle(.borderedProminent)
        }
    }
}

private struct DefaultPermissionDeniedView: View {
    let kind: PermissionKind
    let action: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Text("Enable \(kind.title) permission in Settings.")
                .multilineTextAlignment(.center)

            Button("Open Settings", action: action)
                .buttonStyle(.bordered)
        }
    }
}

#endif

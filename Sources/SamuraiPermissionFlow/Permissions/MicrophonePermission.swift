//
//  MicrophonePermission.swift
//  SamuraiPermissionFlow
//
//  Created by Ksyuleg on 09.07.2026.
//

#if os(iOS)

import AVFoundation

/// Handles microphone permission.
///
/// README note:
/// To request microphone permission, the host app must include
/// `NSMicrophoneUsageDescription` in its Info.plist.
public struct MicrophonePermission: PermissionProvider {

    public init() {}

    public var status: PermissionStatus {
        get async {
            Self.mapStatus(
                AVAudioSession.sharedInstance().recordPermission
            )
        }
    }

    public func request() async -> PermissionStatus {
        let currentStatus = AVAudioSession.sharedInstance().recordPermission

        switch currentStatus {
        case .granted:
            return .authorized
        case .denied:
            return .denied
        case .undetermined:
            let granted = await withCheckedContinuation { continuation in
                AVAudioSession.sharedInstance().requestRecordPermission { granted in
                    continuation.resume(returning: granted)
                }
            }
            return granted ? .authorized : .denied
        @unknown default:
            return .denied
        }
    }

    private static func mapStatus(_ status: AVAudioSession.RecordPermission) -> PermissionStatus {
        switch status {
        case .undetermined:
            return .notDetermined
        case .denied:
            return .denied
        case .granted:
            return .authorized
        @unknown default:
            return .denied
        }
    }
}

#endif

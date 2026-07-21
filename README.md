# SamuraiPermissionFlow

SamuraiPermissionFlow is a lightweight iOS Swift Package for working with app permissions using async/await and SwiftUI permission gates.

## Features

- Camera permission
- Microphone permission
- Photo library permission
- Notifications permission
- Location When In Use permission
- Open app settings helper
- Unified `PermissionStatus`
- Unified async/await API
- `PermissionKind`-based API
- Reusable SwiftUI `PermissionGate`
- No external dependencies

## Demo App

Explore a complete SwiftUI integration in [SamuraiPermissionFlowDemo](https://github.com/TDMNS/SamuraiPermissionFlowDemo).

The demo includes a permission dashboard for camera, microphone, photos, notifications, and location. It demonstrates checking and requesting access, opening Settings, using `PermissionGate`, and organizing the app with lightweight MVVM. The interface also supports dark mode, accessibility, and ProMotion.

<p align="center">
  <a href="https://github.com/TDMNS/SamuraiPermissionFlowDemo">
    <img src="https://raw.githubusercontent.com/TDMNS/SamuraiPermissionFlowDemo/main/Docs/dashboard.png" alt="SamuraiPermissionFlowDemo permission dashboard" width="280">
  </a>
</p>

[View the demo repository →](https://github.com/TDMNS/SamuraiPermissionFlowDemo)

For a minimal package-only example, see [`Examples/ExampleView.swift`](Examples/ExampleView.swift).

## Requirements

- iOS 15+
- Swift 5.9+

## Info.plist

Some permissions require usage descriptions in the host app's `Info.plist`.

In Xcode, open your app target → `Info` → `Custom iOS Target Properties` and add:

| Xcode name | Raw key |
|---|---|
| Privacy - Camera Usage Description | `NSCameraUsageDescription` |
| Privacy - Microphone Usage Description | `NSMicrophoneUsageDescription` |
| Privacy - Photo Library Usage Description | `NSPhotoLibraryUsageDescription` |
| Privacy - Location When In Use Usage Description | `NSLocationWhenInUseUsageDescription` |

Example values:

```text
Camera access is needed to take photos.
Microphone access is needed to record audio.
Photo library access is needed to select photos.
Location access is needed to show nearby places.
```

Without the required usage description, iOS may terminate the app when requesting authorization.

## Installation

### Swift Package Manager

In Xcode:

1. Open your project.
2. Go to `File` → `Add Package Dependencies...`.
3. Enter the repository URL:

```text
https://github.com/TDMNS/SamuraiPermissionFlow
```

4. Add `SamuraiPermissionFlow` to your app target.

## Usage

Import the package:

```swift
import SamuraiPermissionFlow
```

### Check permission status

```swift
let status = await SamuraiPermission.camera.status
```

### Request permission

```swift
let status = await SamuraiPermission.camera.request()

switch status {
case .authorized:
    print("Access granted")

case .denied:
    PermissionSettings.open()

case .notDetermined:
    print("Permission has not been requested yet")

case .restricted:
    print("Permission is restricted")

case .limited:
    print("Limited access")
}
```

The existing provider-based API remains available. You can also use the unified API with `PermissionKind`:

```swift
let status = await SamuraiPermission.status(.camera)
let newStatus = await SamuraiPermission.request(.camera)
```

## Supported Permissions

| Permission | Provider | Required usage description |
|---|---|---|
| Camera | `SamuraiPermission.camera` | `NSCameraUsageDescription` |
| Microphone | `SamuraiPermission.microphone` | `NSMicrophoneUsageDescription` |
| Photos | `SamuraiPermission.photos` | `NSPhotoLibraryUsageDescription` |
| Notifications | `SamuraiPermission.notifications` | None; user authorization is still required |
| Location When In Use | `SamuraiPermission.location` | `NSLocationWhenInUseUsageDescription` |

### Camera

```swift
let status = await SamuraiPermission.camera.request()
```

Required `Info.plist` key:

```text
NSCameraUsageDescription
```

Xcode name:

```text
Privacy - Camera Usage Description
```

### Microphone

```swift
let status = await SamuraiPermission.microphone.request()
```

Required `Info.plist` key:

```text
NSMicrophoneUsageDescription
```

Xcode name:

```text
Privacy - Microphone Usage Description
```

### Photos

```swift
let status = await SamuraiPermission.photos.request()
```

Required `Info.plist` key:

```text
NSPhotoLibraryUsageDescription
```

Xcode name:

```text
Privacy - Photo Library Usage Description
```

`PhotosPermission` supports `.limited` status.

### Notifications

```swift
let status = await SamuraiPermission.notifications.request()
```

Notification permission does not require an `Info.plist` usage description, but the app must request user authorization.

### Location When In Use

```swift
let status = await SamuraiPermission.location.request()
```

Required `Info.plist` key:

```text
NSLocationWhenInUseUsageDescription
```

Xcode name:

```text
Privacy - Location When In Use Usage Description
```

Without this key, iOS may terminate the app when requesting authorization.

Note: Location Services must be enabled on the device. If Location Services are disabled globally, iOS may not show the regular permission request flow.

## Open Settings

If the user denied permission, iOS usually does not show the system permission alert again. In this case, open the app settings screen:

```swift
PermissionSettings.open()
```

Example:

```swift
let status = await SamuraiPermission.camera.request()

if status.requiresSettings {
    await PermissionSettings.open()
}
```

## PermissionStatus

SamuraiPermissionFlow maps different Apple permission statuses to one unified enum:

```swift
public enum PermissionStatus: Equatable, Sendable, CustomStringConvertible {
    case notDetermined
    case authorized
    case denied
    case restricted
    case limited
}
```

Convenience properties are available for common permission flows:

```swift
if status.isGranted {
    // Continue with the protected feature.
} else if status.requiresSettings {
    PermissionSettings.open()
} else if status.canRequest {
    let newStatus = await SamuraiPermission.request(.camera)
}
```

Available helpers:

- `isGranted`
- `isDenied`
- `isRestricted`
- `isNotDetermined`
- `isLimited`
- `requiresSettings`
- `canRequest`

Every `PermissionProvider` also provides async convenience methods:

```swift
let isGranted = await SamuraiPermission.camera.isGranted()
let requiresSettings = await SamuraiPermission.camera.requiresSettings()
```

## SwiftUI PermissionGate

`PermissionGate` displays its content only while the requested permission is granted:

```swift
PermissionGate(.camera) {
    CameraView()
}
```

Set `requestOnAppear` to request an undetermined permission automatically once:

```swift
PermissionGate(.camera, requestOnAppear: true) {
    CameraView()
}
```

Custom request and denied views are also supported:

```swift
PermissionGate(
    .camera,
    requestOnAppear: false
) {
    CameraView()
} request: {
    CustomRequestView()
} denied: {
    CustomDeniedView()
}
```

The default denied view includes an **Open Settings** button. Settings are never opened automatically.

## Continuous Integration

GitHub Actions verifies the package with both SwiftPM on macOS and the complete test suite on an iOS Simulator.

## Current Limitations

- iOS-first package
- Only Location When In Use is supported
- Location Always is not implemented yet
- Contacts, Calendar, and Bluetooth permissions are not implemented yet
- No UIKit helper screens yet
- Notification `.provisional` and `.ephemeral` are currently mapped to `.authorized`
- Unit tests do not trigger real system permission alerts

## Roadmap

- Location Always
- Contacts
- Calendar
- Bluetooth
- UIKit helper screens
- Better notification status granularity
- DocC documentation

## License

MIT

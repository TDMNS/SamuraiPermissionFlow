# SamuraiPermissionFlow

A lightweight iOS Swift package for working with app permissions using a simple async/await API.

## Features

- Camera permission
- Microphone permission
- Photo library permission
- Notifications permission
- Location When In Use permission
- Open app settings helper
- Unified `PermissionStatus`
- Unified API through `PermissionKind`
- Reusable SwiftUI `PermissionGate`
- Swift Concurrency support

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

Recommended `Info.plist` key:

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

Notification permission does not require an `Info.plist` usage description.

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

SamuraiPermissionFlow reports globally disabled Location Services as `.restricted`, because location is unavailable at the system level rather than denied specifically for the app.

## Open Settings

If the user denied permission, iOS usually does not show the system permission alert again. In this case, open the app settings screen:

```swift
PermissionSettings.open()
```

Example:

```swift
let status = await SamuraiPermission.camera.request()

if status == .denied {
    PermissionSettings.open()
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

## Example

A simple SwiftUI example is available in:

```text
Examples/ExampleView.swift
```

## Current Limitations

- iOS-first package
- Only Location When In Use is supported
- No UIKit helper screens yet
- Notification `.provisional` and `.ephemeral` are currently mapped to `.authorized`

## License

MIT

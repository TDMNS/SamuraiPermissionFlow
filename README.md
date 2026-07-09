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
- Swift Concurrency support

## Requirements

- iOS 15+
- Swift 5.9+

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
    await PermissionSettings.open()

case .notDetermined:
    print("Permission has not been requested yet")

case .restricted:
    print("Permission is restricted")

case .limited:
    print("Limited access")
}
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

### Microphone

```swift
let status = await SamuraiPermission.microphone.request()
```

Required `Info.plist` key:

```text
NSMicrophoneUsageDescription
```

### Photos

```swift
let status = await SamuraiPermission.photos.request()
```

Recommended `Info.plist` key:

```text
NSPhotoLibraryUsageDescription
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

Without this key, iOS may terminate the app when requesting authorization.

## Open Settings

If the user denied permission, iOS usually does not show the system permission alert again. In this case, open the app settings screen:

```swift
await PermissionSettings.open()
```

Example:

```swift
let status = await SamuraiPermission.camera.request()

if status == .denied {
    await PermissionSettings.open()
}
```

## PermissionStatus

SamuraiPermissionFlow maps different Apple permission statuses to one unified enum:

```swift
public enum PermissionStatus: Equatable, Sendable {
    case notDetermined
    case authorized
    case denied
    case restricted
    case limited
}
```

## Current Limitations

- iOS-first package
- Only Location When In Use is supported
- No SwiftUI permission gate yet
- No UIKit helper screens yet
- Notification `.provisional` and `.ephemeral` are currently mapped to `.authorized`

## License

MIT

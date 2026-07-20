# AGENTS.md

## Project Overview

SamuraiPermissionFlow is an iOS-first Swift Package for working with app permissions using async/await and SwiftUI.

The package provides permission providers for common iOS permissions and aims to keep the API lightweight, explicit, and easy to integrate.

## Core Principles

- Keep the SDK iOS-first.
- Keep the public API small and stable.
- Prefer simple, readable Swift over clever abstractions.
- Do not add external dependencies.
- Do not break existing public API unless explicitly requested.
- Preserve backward compatibility for v0.x whenever possible.
- Keep all permission APIs async/await friendly.
- Do not trigger real system permission alerts in unit tests.
- Test pure mapping logic and helper logic instead.

## Platform Requirements

- Swift 5.9+
- iOS 15+
- Swift Package Manager
- No external dependencies

## Existing Public API That Must Stay Working

- `SamuraiPermission.camera.status`
- `SamuraiPermission.camera.request()`
- `SamuraiPermission.microphone.status`
- `SamuraiPermission.microphone.request()`
- `SamuraiPermission.photos.status`
- `SamuraiPermission.photos.request()`
- `SamuraiPermission.notifications.status`
- `SamuraiPermission.notifications.request()`
- `SamuraiPermission.location.status`
- `SamuraiPermission.location.request()`
- `PermissionSettings.open()`

## Coding Guidelines

- Use clear access control.
- Keep internal helpers internal or private.
- Do not expose implementation details as public API.
- Keep `LocationPermissionRequester` internal.
- Keep `mapStatus` functions internal, not public.
- Use `#if os(iOS)` for iOS-only APIs.
- Avoid deprecated APIs when a modern alternative is available.
- Avoid unnecessary classes when structs are enough.
- Avoid over-engineered generics unless they clearly reduce complexity.

## Concurrency Guidelines

- Respect Swift concurrency rules.
- Avoid storing non-Sendable Apple framework objects inside Sendable types.
- Use `@MainActor` where UIKit, UIApplication, SwiftUI, or CoreLocation main-thread behavior requires it.
- Avoid double-resuming continuations.
- Clean up retained request helpers after completion.

## Testing Guidelines

- Always run `swift build` and `swift test` after changes.
- Do not write tests that trigger real iOS permission dialogs.
- Prefer tests for:
  - `PermissionStatus` helpers
  - `PermissionKind` mapping
  - system status mapping functions
  - provider extensions
  - pure utility logic
- Use mocks inside the test target when needed.

## README Guidelines

- README must match the real implemented API.
- Do not document features that are not implemented.
- Keep the README technical and concise.
- Show installation, Info.plist keys, basic usage, `PermissionKind` usage, SwiftUI `PermissionGate` usage, supported permissions, limitations, and roadmap.

## Forbidden Changes Unless Explicitly Requested

- Do not change `LICENSE`.
- Do not rename the package.
- Do not rename `SamuraiPermissionFlow`.
- Do not rename `SamuraiPermission`.
- Do not create release tags.
- Do not publish GitHub releases.
- Do not add dependencies.
- Do not remove existing public APIs.

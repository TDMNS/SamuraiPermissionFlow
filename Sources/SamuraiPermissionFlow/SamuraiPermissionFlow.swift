import Foundation

public enum PermissionStatus: Equatable, Sendable {
    case notDetermined
    case authorized
    case denied
    case restricted
    case limited
}

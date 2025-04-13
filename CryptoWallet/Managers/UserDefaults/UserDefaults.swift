
import Foundation


protocol UserDefaultsProtocol: AnyObject {
    func setAuthorizationStatus(_ isAuthorized: Bool)
    func getAuthorizationStatus() -> Bool
    func deleteAuthStatus()
}

final class UserDefaultsManager: UserDefaultsProtocol {
    
    private let userDefaults = UserDefaults.standard
    private let authorizationKey = "isAuthorized"
    
    func setAuthorizationStatus(_ isAuthorized: Bool) {
        userDefaults.set(isAuthorized, forKey: authorizationKey)
    }
    
    func deleteAuthStatus() {
        userDefaults.removeObject(forKey: authorizationKey)
    }
    
    func getAuthorizationStatus() -> Bool {
        return userDefaults.bool(forKey: authorizationKey)
    }
}

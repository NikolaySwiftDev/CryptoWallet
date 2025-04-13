
import Foundation
import UIKit

protocol RouterMain {
    var navigationController: UINavigationController { get set }
    var builder: BuilderProtocol? { get set }
}

protocol RouterMainProtocol: RouterMain {
    func initialViewController()
    func pushTabBarVC()
    func pushAuthVC()
    func pushDetailVC(model: CryptoMetrics)
    func logOut()
    func popVC()
    func showNetworkData(title: String)
    func showAuthErrorAlert(handelr: @escaping()->())
}

class Router: RouterMainProtocol {
    
    var navigationController: UINavigationController
    var userDefaults: UserDefaultsProtocol
    var builder: BuilderProtocol?
    
    init(navigationController: UINavigationController, builder: BuilderProtocol, userDefaults: UserDefaultsProtocol) {
        self.navigationController = navigationController
        self.builder = builder
        self.userDefaults = userDefaults
    }
    
    //MARK: - Initial View Controller
    func initialViewController() {
        if userDefaults.getAuthorizationStatus() {
            guard let mainVC = builder?.createTabbarVC(router: self) else { return }
            navigationController.viewControllers = [mainVC]
            navigationController.setNavigationBarHidden(true, animated: true)
        } else {
            guard let mainVC = builder?.createAuthVC(router: self) else { return }
            navigationController.viewControllers = [mainVC]
            navigationController.setNavigationBarHidden(true, animated: true)
        }
    }
    
    //MARK: - Push Tab Bar View Controller
    func pushTabBarVC() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate,
              let tabbarVC = builder?.createTabbarVC(router: self) else {
            return
        }

        navigationController = UINavigationController(rootViewController: tabbarVC)
        navigationController.setNavigationBarHidden(true, animated: true)
        sceneDelegate.window?.rootViewController = navigationController
        sceneDelegate.window?.makeKeyAndVisible()
    }
    
    //MARK: - Push Auth View Controller
    func pushAuthVC() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate,
              let tabbarVC = builder?.createAuthVC(router: self) else {
            return
        }
        
        navigationController = UINavigationController(rootViewController: tabbarVC)
        navigationController.setNavigationBarHidden(true, animated: true)
        sceneDelegate.window?.rootViewController = navigationController
        sceneDelegate.window?.makeKeyAndVisible()
    }
    
    //MARK: - Push to Detail VC
    func pushDetailVC(model: CryptoMetrics) {
        guard let detailVC = builder?.createDetailVC(router: self, model: model) else { return }
        
        if let tabBarController = navigationController.topViewController as? UITabBarController {
            if let selectedNavigationController = tabBarController.selectedViewController as? UINavigationController {
                selectedNavigationController.pushViewController(detailVC, animated: true)
            }
        }
    }

    //MARK: - Log Out
    func logOut() {
        userDefaults.setAuthorizationStatus(false)
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate,
              let tabbarVC = builder?.createAuthVC(router: self) else {
            return
        }
        
        navigationController = UINavigationController(rootViewController: tabbarVC)
        navigationController.setNavigationBarHidden(true, animated: true)
        sceneDelegate.window?.rootViewController = navigationController
        sceneDelegate.window?.makeKeyAndVisible()
    }
    
    //MARK: - Pop VC
    func popVC() {
        if let tabBarController = navigationController.topViewController as? UITabBarController {
            if let selectedNavigationController = tabBarController.selectedViewController as? UINavigationController {
                selectedNavigationController.popViewController(animated: true)
            }
        } else {
            navigationController.popViewController(animated: true)
        }
    }

    
    //MARK: - Show Auth Error Alert
    func showAuthErrorAlert(handelr: @escaping()->()) {
        let alert = UIAlertController(title: "Incorrect login or password entered",
                                      message: nil,
                                      preferredStyle: .alert)
        let repeatAction = UIAlertAction(title: "Repeat",
                                         style: .default) { handler in
            handelr()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addAction(repeatAction)
        alert.addAction(cancelAction)
        
        navigationController.present(alert, animated: true)
    }
    
    //MARK: - Show Networ kData
    func showNetworkData(title: String) {
        let alert = UIAlertController(title: title,
                                      message: nil,
                                      preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addAction(cancelAction)
        
        navigationController.present(alert, animated: true)
    }
}

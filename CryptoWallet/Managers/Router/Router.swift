
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
    func logOut()
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
    
    func logOut() {
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

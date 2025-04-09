
import Foundation
import UIKit

protocol BuilderProtocol: AnyObject {
    func createTabbarVC(router: RouterMainProtocol) -> UIViewController
    func createAuthVC(router: RouterMainProtocol) -> UIViewController
}

class Builder: BuilderProtocol {
    func createTabbarVC(router: RouterMainProtocol) -> UIViewController {
        let homeModel = TabBarModel(vc: createHomeVC(router: router),
                                    selectedImage: "home")
        
        let marketModel = TabBarModel(vc: createEmptyVC(.systemYellow),
                                      selectedImage: "market")
        
        let walletModel = TabBarModel(vc: createEmptyVC(.systemBlue),
                                      selectedImage: "wallet")
        
        let documentModel = TabBarModel(vc: createEmptyVC(.systemMint),
                                         selectedImage: "document")
        
        let personModel = TabBarModel(vc: createEmptyVC(.systemPurple),
                                    selectedImage: "personal")
                                        
        
        let tabbarControllers = TabBarModels(cells: [homeModel,
                                                     marketModel,
                                                     walletModel,
                                                     documentModel,
                                                     personModel
                                                    ])
        
        let view = TabBarViewController()
        let presenter = TabBarPresenter(view: view,
                                        model: tabbarControllers)
        view.presenter = presenter
        return view
    }
    
    func createEmptyVC(_ color: UIColor) -> UIViewController {
        let view = UIViewController()
        view.view.backgroundColor = color
        return view
    }
    
    func createAuthVC(router: RouterMainProtocol) -> UIViewController {
        let view = AuthViewController()
        let userDefaults = UserDefaultsManager()
        let presenter = AuthPresenter(view: view, router: router, userDefaults: userDefaults)
        view.presenter = presenter
        return view
    }
    
    func createHomeVC(router: RouterMainProtocol) -> UIViewController {
        let view = HomeViewController()
        let network = NetworkService()
        let presenter = HomePresenter(view: view, router: router, network: network)
        view.presenter = presenter
        return view
    }
}

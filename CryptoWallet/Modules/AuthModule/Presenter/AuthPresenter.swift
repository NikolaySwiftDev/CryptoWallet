protocol AuthProtocol: AnyObject {
    func cleanTextField()
}

protocol AuthPresenterProtocol: AnyObject {
    func saveNewStatusAuthAndPush(user: String, password: String)
    init(view: AuthProtocol, router: RouterMainProtocol, userDefaults: UserDefaultsProtocol)
}

class AuthPresenter: AuthPresenterProtocol {
    weak var view: AuthProtocol?
    let userDefaults: UserDefaultsProtocol?
    let router: RouterMainProtocol?

    required init(view: AuthProtocol, router: RouterMainProtocol, userDefaults: UserDefaultsProtocol) {
        self.view = view
        self.userDefaults = userDefaults
        self.router = router
    }
    
    func saveNewStatusAuthAndPush(user: String, password: String) {
        if user == "1234" && password == "1234" {
            userDefaults?.setAuthorizationStatus(true)
            router?.pushTabBarVC()
        } else {
            router?.showAuthErrorAlert(handelr: { [weak self] in
                guard let self = self else {return}
                view?.cleanTextField()
            })
        }
    }
}


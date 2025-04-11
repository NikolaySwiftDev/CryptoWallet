protocol DetailProtocol: AnyObject {
    func getModel(model: CryptoMetrics)
}

protocol DetailPresenterProtocol: AnyObject {
    var model: CryptoMetrics? { get }
    init(view: DetailProtocol, router: RouterMainProtocol, model: CryptoMetrics)
    func popVC()
}

class DetailPresenter: DetailPresenterProtocol {
    weak var view: DetailProtocol?
    var model: CryptoMetrics?
    let router: RouterMainProtocol?

    required init(view: DetailProtocol, router: RouterMainProtocol, model: CryptoMetrics) {
        self.view = view
        self.router = router
        self.model = model
        view.getModel(model: model)
    }
    
    func popVC() {
        router?.popVC()
    }
    
}

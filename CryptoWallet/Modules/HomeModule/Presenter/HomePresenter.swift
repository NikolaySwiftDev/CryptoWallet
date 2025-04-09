import Foundation

protocol HomeProtocol: AnyObject {
    func success(array: [CryptoMetrics])
    func error(error: Error)
}

protocol HomePresenterProtocol: AnyObject {
    var cryptos: [CryptoMetrics]? { get set }
    func fetchCryptoMetrics()
    init(view: HomeProtocol, router: RouterMainProtocol, network: NetworkServiceProtocol)
}

class HomePresenter: HomePresenterProtocol {
    weak var view: HomeProtocol?
    var cryptos: [CryptoMetrics]?
    let router: RouterMainProtocol?
    let network: NetworkServiceProtocol?
   
    
    required init(view: HomeProtocol, router: RouterMainProtocol, network: NetworkServiceProtocol) {
        self.view = view
        self.router = router
        self.network = network
    }
    
    func fetchCryptoMetrics() {
        network?.fetchCryptoMetrics(completion: { [weak self] cryptos, error in
            guard let self = self else { return }
            if let error = error {
                DispatchQueue.main.async {
                    self.view?.error(error: error)
                    self.router?.showNetworkData(title: error.localizedDescription)
                }
            } else {
                DispatchQueue.main.async {
                    self.cryptos = cryptos
                    self.view?.success(array: cryptos ?? [CryptoMetrics]())
                }
            }
        })
    }
}

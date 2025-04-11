import Foundation

protocol HomeProtocol: AnyObject {
    func success(array: [CryptoMetrics])
    func error(error: Error)
}

protocol HomePresenterProtocol: AnyObject {
    var cryptos: [CryptoMetrics]? { get set }
    func fetchCryptoMetrics()
    func filterCryptosData(by option: SortOption)
    func logOut()

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
                    if let data = cryptos?.sorted(by: { $0.name.lowercased() < $1.name.lowercased() }) {
                        self.cryptos = data
                        self.view?.success(array: data)
                    }
                }
            }
        })
    }
    
    func filterCryptosData(by option: SortOption) {
        guard let cryptos = cryptos else {
            self.router?.showNetworkData(title: "No data")
            return
        }
        
        let sortedData: [CryptoMetrics]

        switch option {
        case .name(let ascending):
            sortedData = cryptos.sorted {
                ascending
                    ? $0.name.lowercased() < $1.name.lowercased()
                    : $0.name.lowercased() > $1.name.lowercased()
            }
        case .price(let ascending):
            sortedData = cryptos.sorted {
                let lhs = $0.marketData.priceUsd ?? 0
                let rhs = $1.marketData.priceUsd ?? 0
                return ascending ? lhs < rhs : lhs > rhs
            }
        }

        self.view?.success(array: sortedData)
    }
    
    func logOut() {
        router?.logOut()
    }
    
}

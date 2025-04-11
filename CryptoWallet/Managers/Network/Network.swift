import Foundation

// MARK: - Network Service Protocol
protocol NetworkServiceProtocol: AnyObject {
    func fetchCryptoMetrics(completion: @escaping ([CryptoMetrics]?, Error?) -> Void)
}

// MARK: - Network Service
final class NetworkService: NetworkServiceProtocol {
    
    private let baseURL = "https://data.messari.io/api/v1/assets"
    private let session = URLSession.shared
    private let symbols = ["btc", "eth", "tron", "luna", "polkadot", "dogecoin", "tether", "stellar", "cardano", "xrp"]
    
    func fetchCryptoMetrics(completion: @escaping ([CryptoMetrics]?, Error?) -> Void) {
        var results: [CryptoMetrics] = []
        let group = DispatchGroup()
        
        for symbol in symbols {
            guard let url = URL(string: "\(baseURL)/\(symbol)/metrics") else { continue }
            
            group.enter()
            session.dataTask(with: url) { data, response, error in
                defer { group.leave() }
                
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                guard let data = data else { return }
                do {
                    let decoded = try JSONDecoder().decode(CryptoMetricsResponse.self, from: data)
                    results.append(decoded.data)
                } catch {
                    completion(nil, error)
                }
            }.resume()
        }
        
        group.notify(queue: .main) {
            completion(results, nil)
        }
    }
}

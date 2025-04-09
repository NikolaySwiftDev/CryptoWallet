struct CryptoMetricsResponse: Codable {
    let data: CryptoMetrics
}

struct CryptoMetrics: Codable {
    let id: String
    let symbol: String
    let name: String
    let marketData: MarketData
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case marketData = "market_data"
    }
}

struct MarketData: Codable {
    let priceUsd: Double?
    
    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
    }
}

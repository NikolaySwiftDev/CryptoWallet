struct CryptoMetricsResponse: Codable {
    let data: CryptoMetrics
}

struct CryptoMetrics: Codable {
    let id: String
    let symbol: String
    let name: String
    let marketData: MarketData
    let marketcap: MarketcapData
    let supply: SupplyData
    let roiData: RoiData
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case marketData = "market_data"
        case marketcap
        case supply
        case roiData = "roi_data"
    }
}

struct MarketData: Codable {
    let priceUsd: Double?
    let percentChangeLast1Hour: Double?
    let percentChangeLast24Hours: Double?

    
    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case percentChangeLast1Hour = "percent_change_usd_last_1_hour"
        case percentChangeLast24Hours = "percent_change_usd_last_24_hours"
    }
    
    var isUpPercentChangeLast24Hours: Bool {
        return (percentChangeLast24Hours ?? 0) > 0
    }
}

struct MarketcapData: Codable {
    let currentMarketcapUsd: Double?
    
    enum CodingKeys: String, CodingKey {
        case currentMarketcapUsd = "current_marketcap_usd"
    }
}

struct SupplyData: Codable {
    let circulatingSupply: Double?
    
    enum CodingKeys: String, CodingKey {
        case circulatingSupply = "circulating"
    }
}

struct RoiData: Codable {
        let percentChangeLastWeek: Double?
        let percentChangeLastMonth: Double?
        let percentChangeLastThreeMonths: Double?
        let percentChangeLastYear: Double?
    
    enum CodingKeys: String, CodingKey {
        case percentChangeLastWeek = "percent_change_last_1_week"
        case percentChangeLastMonth = "percent_change_last_1_month"
        case percentChangeLastThreeMonths = "percent_change_last_3_months"
        case percentChangeLastYear = "percent_change_last_1_year"
    }
}


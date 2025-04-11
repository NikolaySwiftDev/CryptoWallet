import Foundation

extension Double {
    func formatCurrency(with symbol: String = "$") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = symbol
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.locale = Locale(identifier: "en_US")

        return formatter.string(from: NSNumber(value: self)) ?? "\(symbol) \(self)"
    }
    
    func formatPercent(with decimalPlaces: Int = 2, for str: String = "%") -> String {
        return String(format: "%.\(decimalPlaces)f", self) + " \(str)"
    }
    

}

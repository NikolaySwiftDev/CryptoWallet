
import UIKit

enum FontWeight: String {
    case regular = "Regular" //400
    case medium = "Medium" //500
    case semiBold = "SemiBold" //600
}

extension UIFont {
    static func poppins(weight: FontWeight, size: CGFloat) -> UIFont {
        let fontName = "Poppins-\(weight.rawValue)"
        
        if let font = UIFont(name: fontName, size: size) {
            return font
        } else {
            print("Standart Font")
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
    }
}


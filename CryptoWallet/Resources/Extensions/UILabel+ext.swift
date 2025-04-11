import UIKit

extension UILabel {
    convenience init(
        text: String? = nil,
        font: UIFont = UIFont.poppins(weight: .medium, size: 18),
        textColor: UIColor = .darkBlue,
        textAlignment: NSTextAlignment = .center,
        adjustsFontSizeToFitWidth: Bool = true,
        numberOfLines: Int = 0
    ) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        self.numberOfLines = numberOfLines
    }
}

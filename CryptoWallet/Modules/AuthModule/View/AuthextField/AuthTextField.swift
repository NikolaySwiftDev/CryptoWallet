import UIKit
import SnapKit

final class AuthTextFieldView: UIView, UITextFieldDelegate {

    // MARK: - Subviews
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()

    let textField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.poppins(weight: .regular, size: 16)
        tf.textColor = .darkGray
        tf.autocapitalizationType = .sentences
        return tf
    }()

    // MARK: - Init
    init(icon: String, placeholder: String) {
        super.init(frame: .zero)
        setupView()
        configure(icon: icon, placeholder: placeholder)
        textField.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 28
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.03
        layer.shadowOffset = .zero
        layer.shadowRadius = 6

        addSubview(iconView)
        addSubview(textField)

        iconView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 40))
        }

        textField.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(12)
            make.right.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.height.equalTo(44)
        }
    }

    private func configure(icon: String, placeholder: String) {
        iconView.image = UIImage(named: icon)
        textField.placeholder = placeholder
    }
}


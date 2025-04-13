
import UIKit
import SnapKit

final class AuthViewController: UIViewController {

    //MARK: - Properties
    var presenter: AuthPresenterProtocol?
    private var user = String()
    private var password = String()
    
    private let logoImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(resource: .authLogo)
        return img
    }()
    
    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = AuthConstants.loginButtonColor
        btn.layer.cornerRadius = AuthConstants.cornerRadius
        btn.titleLabel?.font = UIFont.poppins(weight: .semiBold, size: 15)
        btn.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private let userTextField = AuthTextFieldView(icon: "userImage", placeholder: "Username")
    private let passwordTextField = AuthTextFieldView(icon: "passwordimage", placeholder: "Password")
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupContraints()
        configTextFields()
    }
    
    //MARK: - Config TextFields
    private func configTextFields() {
        userTextField.textField.addTarget(self, action: #selector(userTextChanged(_:)), for: .editingChanged)
        passwordTextField.textField.addTarget(self, action: #selector(passwordTextChanged(_:)), for: .editingChanged)
    }

    //MARK: - User Text Changed
    @objc func userTextChanged(_ textField: UITextField) {
        self.user = textField.text ?? ""
    }

    //MARK: - Password Text Changed
    @objc func passwordTextChanged(_ textField: UITextField) {
        self.password = textField.text ?? ""
    }
    
    //MARK: - Login Button Tapped
    @objc private func loginButtonTapped() {
        presenter?.saveNewStatusAuthAndPush(user: user, password: password)
    }
}

//MARK: - AuthProtocol
extension AuthViewController: AuthProtocol {
    func cleanTextField() {
        userTextField.textField.text = ""
        self.password = ""     
        
        passwordTextField.textField.text = ""
        self.password = ""
    }
}

//MARK: - UITextFieldDelegate
extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let user = userTextField.textField.text else {return false}
        self.user = user
        
        guard let password = passwordTextField.textField.text else {return false}
        self.password = password
        textField.resignFirstResponder()
        return true
    }

}



//MARK: - Extension SetupView and SetupContraints
extension AuthViewController {
    private func setupView() {
        view.backgroundColor = AuthConstants.backgroundColor
        
        view.addSubview(logoImage)
        view.addSubview(loginButton)
        view.addSubview(userTextField)
        view.addSubview(passwordTextField)
        
        userTextField.textField.delegate = self
        passwordTextField.textField.delegate = self
    }
    
    private func setupContraints() {
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(AuthConstants.viewWidth - 80)
        }
        
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-100)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(55)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.bottom.equalTo(loginButton.snp.top).offset(-20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(55)
        }
        
        userTextField.snp.makeConstraints { make in
            make.bottom.equalTo(passwordTextField.snp.top).offset(-20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(55)
        }
    }
}

//MARK: - Auth Constants
fileprivate struct AuthConstants {
    static let backgroundColor = UIColor(.backgrWhite)
    static let loginButtonColor = UIColor(.darkBlue)
    static let viewWidth: CGFloat = UIScreen.main.bounds.width
    static let cornerRadius: CGFloat = 20
}

import UIKit
final class ThirdViewController: UIViewController {

    //MARK: - Properties
    var presenter: AuthPresenterProtocol?
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

//MARK: - Extension SetupView and SetupContraints
extension ThirdViewController {
    private func setupView() {
        
    }
    
    private func setupContraints() {
        
    }
}

//MARK: - AuthProtocol
//extension ThirdViewController: AuthProtocol {
//    func get() {}
//}

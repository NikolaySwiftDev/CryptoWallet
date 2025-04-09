
import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    //MARK: - Properties
    var presenter: HomePresenterProtocol?
    var cryptosData: [CryptoMetrics]?
    
    private let titleHome: UILabel = {
        let label = UILabel()
        label.text = "Home"
        label.textColor = .white
        label.font = UIFont.poppins(weight: .semiBold, size: 32)
        return label
    }()
    
    private let moreButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("...", for: .normal)
        btn.setTitleColor(.darkBlue, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 24
        btn.clipsToBounds = true
        btn.titleEdgeInsets = UIEdgeInsets(top: -5, left: 0, bottom: 5, right: 0)
        return btn
    }()


    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.layer.cornerRadius = 0
        tv.clipsToBounds = true
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupContraints()
        configure()
    }
    
    //MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchCryptoMetrics()
    }
}

//MARK: - Extension SetupView and SetupContraints
extension HomeViewController {
    private func setupView() {
        view.backgroundColor = .backHomePink
        
        view.addSubview(titleHome)
        view.addSubview(moreButton)
//        view.addSubview(tableView)
        
    }
    
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CryptoTableViewCell.self,
                           forCellReuseIdentifier: CryptoTableViewCell.cellID)
    }
    
    private func setupContraints() {
        titleHome.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.leading.equalToSuperview().offset(20)
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleHome.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
            make.height.width.equalTo(48)
        }
        
//        tableView.snp.makeConstraints { make in
//            //
//        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cryptosData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.cellID,
                                                                 for: indexPath) as? CryptoTableViewCell else {return UITableViewCell()}
        cell.configure()
        
        return cell
    }
    
    
}

//MARK: - AuthProtocol
extension HomeViewController: HomeProtocol {
    func success(array: [CryptoMetrics]) {
        cryptosData = array
//        print(cryptosData?.count)
    }
    
    func error(error: Error) {}
}

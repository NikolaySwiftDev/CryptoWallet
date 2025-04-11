
import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    //MARK: - Properties
    var presenter: HomePresenterProtocol?
    var cryptosData: [CryptoMetrics]?
    
    private var nameIsAscending = false
    private var priceIsAscending = false
    
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
        btn.backgroundColor = .white.withAlphaComponent(0.8)
        btn.layer.cornerRadius = 24
        btn.clipsToBounds = true
        btn.titleEdgeInsets = UIEdgeInsets(top: -5, left: 0, bottom: 5, right: 0)
        btn.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private let affiliateLable: UILabel = {
        let label = UILabel()
        label.text = "Affiliate program"
        label.textColor = .white
        label.font = UIFont.poppins(weight: .medium, size: 20)
        return label
    }()
    
    private let learnMoreButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Learn more", for: .normal)
        btn.setTitleColor(.darkBlue, for: .normal)
        btn.titleLabel?.font = UIFont.poppins(weight: .semiBold, size: 14)
        btn.backgroundColor = .backgrWhite
        btn.layer.cornerRadius = 17
        btn.clipsToBounds = true
        return btn
    }()
    
    private let boxImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .box)
        return image
    }()
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgrWhite
        view.layer.cornerRadius = 40
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    
    private let trendingLable: UILabel = {
        let label = UILabel()
        label.text = "Trending"
        label.textColor = .darkBlue
        label.font = UIFont.poppins(weight: .medium, size: 20)
        return label
    }()

    private let filterButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(resource: .filter).withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
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
    
    private lazy var moreListView: ListView = {
        let view = ListView(type: .more)
        view.isHidden = true
        return view
    }()
    
    private lazy var filterListView: ListView = {
        let view = ListView(type: .filter)
        view.isHidden = true
        return view
    }()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupContraints()
        configure()
        presenter?.fetchCryptoMetrics()
    }
    
    //MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - More Button Tapped
    @objc private func moreButtonTapped() {
        if moreListView.isHidden {
            moreListView.alpha = 0
            moreListView.transform = CGAffineTransform(translationX: 0, y: -10)
            moreListView.isHidden = false

            UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut], animations: {
                self.moreListView.alpha = 1
                self.moreListView.transform = .identity
            })
        } else {
            UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseIn], animations: {
                self.moreListView.alpha = 0
                self.moreListView.transform = CGAffineTransform(translationX: 0, y: -10)
            }) { _ in
                self.moreListView.isHidden = true
            }
        }
    }

    //MARK: - Filter Button Tapped
    @objc private func filterButtonTapped() {
        if filterListView.isHidden {
            filterListView.alpha = 0
            filterListView.transform = CGAffineTransform(translationX: 0, y: -10)
            filterListView.isHidden = false

            UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut], animations: {
                self.filterListView.alpha = 1
                self.filterListView.transform = .identity
            })
        } else {
            UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseIn], animations: {
                self.filterListView.alpha = 0
                self.filterListView.transform = CGAffineTransform(translationX: 0, y: -10)
            }) { _ in
                self.filterListView.isHidden = true
            }
        }
    }

}

//MARK: - Extension SetupView and SetupContraints
extension HomeViewController {
    private func setupView() {
        view.backgroundColor = .backHomePink
        
        view.addSubview(titleHome)
        view.addSubview(moreButton)
        view.addSubview(affiliateLable)
        view.addSubview(learnMoreButton)
        view.addSubview(boxImage)
        view.addSubview(backView)
        
        view.addSubview(moreListView)
        view.addSubview(filterListView)
        
        backView.addSubview(trendingLable)
        backView.addSubview(filterButton)
        backView.addSubview(tableView)
        
    }
    
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CryptoTableViewCell.self,
                           forCellReuseIdentifier: CryptoTableViewCell.cellID)
        
        moreListView.listDelegate = self
        filterListView.listDelegate = self
    }
    
    private func setupContraints() {
        titleHome.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.leading.equalToSuperview().offset(20)
        }
        
        affiliateLable.snp.makeConstraints { make in
            make.top.equalTo(titleHome.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(20)
        }
        
        learnMoreButton.snp.makeConstraints { make in
            make.top.equalTo(affiliateLable.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(35)
            make.width.equalTo(137)
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleHome.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
            make.height.width.equalTo(48)
        }
        
        moreListView.snp.makeConstraints { make in
            make.top.equalTo(moreButton.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(102)
            make.width.equalTo(157)
        }
        
        boxImage.snp.makeConstraints { make in
            make.top.equalTo(moreButton.snp.bottom).offset(30)
            make.trailing.equalToSuperview()
            make.height.width.equalTo(240)
        }
        
        backView.snp.makeConstraints { make in
            make.top.equalTo(boxImage.snp.centerY).offset(50)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        trendingLable.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
        }

        filterButton.snp.makeConstraints { make in
            make.centerY.equalTo(trendingLable.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
            make.height.width.equalTo(42)
        }
        
        filterListView.snp.makeConstraints { make in
            make.top.equalTo(filterButton.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.height.width.equalTo(157)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(filterButton.snp.bottom)
            make.trailing.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-85)
        }
    }
}
 

//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cryptosData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.cellID,
                                                                 for: indexPath) as? CryptoTableViewCell else {return UITableViewCell()}
        if let modelData = cryptosData {
            let model = modelData[indexPath.row]
            cell.configureCell(title: model.name, desc: model.symbol, price: model.marketData.priceUsd ?? 0, percent: "perc", isUp: true)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

//MARK: - AuthProtocol
extension HomeViewController: HomeProtocol {
    func success(array: [CryptoMetrics]) {
        cryptosData = array
        tableView.reloadData()
    }
    
    func error(error: Error) {}
}

//MARK: - List View Protocols
extension HomeViewController: ListViewDelegate {
    func listView(_ listView: ListView, didSelectItemAt index: Int) {
        if listView == moreListView {
            switch index {
            case 0:
                presenter?.fetchCryptoMetrics()
            case 1:
                presenter?.logOut()
            default:
                break
            }
        } else {
            switch index {
            case 0:
                nameIsAscending = !nameIsAscending
                presenter?.filterCryptosData(by: .name(ascending: nameIsAscending))
            case 1:
                priceIsAscending = !priceIsAscending
                presenter?.filterCryptosData(by: .price(ascending: priceIsAscending))
            case 2:
                print("Filter \(index)")
            default:
                break
            }
        }
    }
}

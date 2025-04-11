import UIKit
final class DetailViewController: UIViewController {
    //MARK: - Properties
    var presenter: DetailPresenterProtocol?
    var model: CryptoMetrics?
    
    private let backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(resource: .arrowBack)
            .withRenderingMode(.alwaysOriginal),
                     for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 28
        btn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private let titleLabel: UILabel = UILabel.init(font: .poppins(weight: .medium, size: 16),
                                                        textColor: .blueText)
    
    private let priceLabel: UILabel = UILabel.init(font: .poppins(weight: .medium, size: 28),
                                                        textColor: .blueText)
    private let percentLabel: UILabel = UILabel.init(font: .poppins(weight: .medium, size: 14),
                                                          textColor: .blueText)
    private let checkImage = UIImageView()
    
    private let timeIntervalCnage = TimeIntervalView()
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    
    private let marketStatsLabel: UILabel = UILabel.init(text: "Market Statistic",
                                                              font: .poppins(weight: .medium, size: 20),
                                                              textColor: .blueText)
    //Market capitalization
    private lazy var marketCapitLabel: UILabel = UILabel.init(text: "Market capitalization",
                                                              font: .poppins(weight: .medium, size: 14),
                                                              textColor: .textDesc)
    private lazy var marketCapitValueLabel: UILabel = UILabel.init(font: .poppins(weight: .semiBold, size: 14),
                                                                   textColor: .blueText)
    
    //Circulating Suply
    private lazy var circulatingLabel: UILabel = UILabel.init(text: "Circulating Suply",
                                                              font: .poppins(weight: .medium, size: 14),
                                                              textColor: .textDesc)
    private lazy var circulatingValueLabel: UILabel = UILabel.init(font: .poppins(weight: .semiBold, size: 14),
                                                                   textColor: .blueText)
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupContraints()
        config()
        configLabels(type: .day)
    }
    
    //MARK: - Back Button Tapped
    @objc private func backButtonTapped() {
        presenter?.popVC()
    }
    
    func config() {
        timeIntervalCnage.delegate = self
        
        guard let model = model else {return}
        titleLabel.text = model.name + " (" + model.symbol + ")"
        priceLabel.text = model.marketData.priceUsd?.formatCurrency()
        
        marketCapitValueLabel.text = model.marketcap.currentMarketcapUsd?.formatCurrency()
        if let circulatingValue = model.supply.circulatingSupply?.formatPercent(with: 3, for: " ") {
            circulatingValueLabel.text =  circulatingValue + model.symbol.uppercased()
        }
    }
    
    // MARK: - Config Labels
    private func configLabels(type: Interval) {
        guard let model = model else { return }

        let percentChange: Double
        switch type {
        case .oneHour:
            percentChange = model.marketData.percentChangeLast1Hour ?? 0
        case .day:
            percentChange = model.marketData.percentChangeLast24Hours ?? 0
        case .oneWeek:
            percentChange = model.roiData.percentChangeLastWeek ?? 0
        case .oneMonth:
            percentChange = model.roiData.percentChangeLastMonth ?? 0
        case .oneYear:
            percentChange = model.roiData.percentChangeLastYear ?? 0
        }

        let isUp = percentChange >= 0

        checkImage.image = UIImage(systemName: isUp ? "chevron.up" : "chevron.down")
        checkImage.tintColor = isUp ? .systemGreen : .systemRed

        percentLabel.text = "\(abs(percentChange).formatPercent())"
        percentLabel.textColor = isUp ? .systemGreen : .systemRed
    }

}

//MARK: - Extension SetupView and SetupContraints
extension DetailViewController {
    private func setupView() {
        view.backgroundColor = .backgrWhite
        
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(priceLabel)
        view.addSubview(percentLabel)
        view.addSubview(checkImage)
        view.addSubview(timeIntervalCnage)
        
        view.addSubview(backView)
        
        backView.addSubview(marketStatsLabel)
        
        backView.addSubview(marketCapitLabel)
        backView.addSubview(marketCapitValueLabel)
        
        backView.addSubview(circulatingLabel)
        backView.addSubview(circulatingValueLabel)
    }
    
    private func setupContraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.width.equalTo(56)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.centerX.equalToSuperview()
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        percentLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview().offset(10)
        }
        
        checkImage.snp.makeConstraints { make in
            make.centerY.equalTo(percentLabel.snp.centerY)
            make.trailing.equalTo(percentLabel.snp.leading).offset(-5)
        }

        timeIntervalCnage.snp.makeConstraints { make in
            make.top.equalTo(percentLabel.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(20)
            make.height.equalTo(55)
        }
        
        backView.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.height / 3.1)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        marketStatsLabel.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.top).offset(40)
            make.leading.equalToSuperview().offset(20)
        }
        
        marketCapitLabel.snp.makeConstraints { make in
            make.top.equalTo(marketStatsLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        circulatingLabel.snp.makeConstraints { make in
            make.top.equalTo(marketCapitLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        marketCapitValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(marketCapitLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        circulatingValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(circulatingLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}

//MARK: - Time Interval View Delegate
extension DetailViewController: TimeIntervalViewDelegate {
    func timeIntervalView(_ view: TimeIntervalView, didSelectInterval interval: Interval) {
        configLabels(type: interval)
    }
}

//MARK: - Detail Protocol
extension DetailViewController: DetailProtocol {
    func getModel(model: CryptoMetrics) {
        self.model = model
    }
}

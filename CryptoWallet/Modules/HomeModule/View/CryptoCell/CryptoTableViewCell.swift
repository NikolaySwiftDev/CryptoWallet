
import UIKit

final class CryptoTableViewCell: UITableViewCell {
    static let cellID = "CryptoTableViewCell"
    
    private let cryptoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bitcoin")
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkBlue
        label.font = UIFont.poppins(weight: .medium, size: 18)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let dascrLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textDesc
        label.font = UIFont.poppins(weight: .medium, size: 14)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let priceLabel: UILabel = UILabel.init()
    private let percentLabel: UILabel = UILabel.init(font: UIFont.poppins(weight: .medium, size: 18))

    private let checkImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }

    //MARK: - Config cell
    func configureCell(title: String, desc: String, price: Double, percent: Double, isUp: Bool) {
        
        titleLabel.text = title
        dascrLabel.text = desc
        priceLabel.text = price.formatCurrency()
        percentLabel.text = percent.formatPercent()
        checkImage.image = isUp ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
        checkImage.tintColor = isUp ? .green : .red
    }
}

    //MARK: - Config, Setup View and Constraints
extension CryptoTableViewCell {
    
    private func setupView() {
        contentView.addSubview(cryptoImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dascrLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(percentLabel)
        contentView.addSubview(checkImage)
    }
    
    private func setupConstraints() {
        cryptoImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-13)
            make.leading.equalTo(cryptoImage.snp.trailing).offset(20)
        }
        
        dascrLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(13)
            make.leading.equalTo(cryptoImage.snp.trailing).offset(20)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        percentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dascrLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        checkImage.snp.makeConstraints { make in
            make.centerY.equalTo(percentLabel.snp.centerY)
            make.trailing.equalTo(percentLabel.snp.leading).offset(-5)
            make.width.equalTo(13)
            make.height.equalTo(16)
        }
    }
    
    private func configure() {
        selectionStyle = .none
        backgroundColor = .clear
        selectedBackgroundView?.backgroundColor = .clear
    }
}

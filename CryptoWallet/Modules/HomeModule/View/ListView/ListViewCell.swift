import UIKit
import SnapKit

final class ListViewCell: UITableViewCell {
    
    static let id = "ListViewCell"

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppins(weight: .medium, size: 18)
        label.numberOfLines = 1
        return label
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        setupViews()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureCell() {
        selectionStyle = .none
        backgroundColor = .clear
    }

    // MARK: - Setup

    private func setupViews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)

        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview().offset(8)
            make.width.height.equalTo(20)
        }

        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(12)
            make.centerY.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(16)
        }
    }

    // MARK: - Configure

    func configure(with text: String, image: String) {
        titleLabel.text = text
        if let image = UIImage(named: image) {
            iconImageView.image = image
        } else {
            iconImageView.image = UIImage(systemName: image)?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.textDesc)
        }
    }
}

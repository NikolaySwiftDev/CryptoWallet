import UIKit

protocol TimeIntervalViewDelegate: AnyObject {
    func timeIntervalView(_ view: TimeIntervalView, didSelectInterval interval: Interval)
}

class TimeIntervalView: UIView {
    
    weak var delegate: TimeIntervalViewDelegate?
    
    private var buttons: [UIButton] = []
    private var selectedButton: UIButton?

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupButtons()
    }
    
    private func setupView() {
        backgroundColor = .intervalGray
        layer.cornerRadius = 24
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
    }

    private func setupButtons() {
        for interval in Interval.allCases {
            let button = UIButton(type: .system)
            button.setTitle(interval.rawValue, for: .normal)
            button.setTitleColor(.gray, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            button.backgroundColor = .clear
            button.layer.cornerRadius = 20
            button.tag = buttons.count
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }

        if buttons.count > 1 {
            selectButton(buttons[1])
        }
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        selectButton(sender)
        let interval = Interval.allCases[sender.tag]
        delegate?.timeIntervalView(self, didSelectInterval: interval)
    }

    private func selectButton(_ button: UIButton) {
        selectedButton?.backgroundColor = .clear
        selectedButton?.setTitleColor(.textDesc, for: .normal)

        button.backgroundColor = .white
        button.setTitleColor(.blueText, for: .normal)
        selectedButton = button
    }
}

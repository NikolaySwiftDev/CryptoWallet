import UIKit

enum ListViewType {
    case more
    case filter
}

protocol ListViewDelegate: AnyObject {
    func listView(_ listView: ListView, didSelectItemAt index: Int)
}

final class ListView: UITableView {
    
    weak var listDelegate: ListViewDelegate?

    private let arrayForButtonsMore = [("Update", "update"), ("Exit", "exit")]
    private let arrayForButtonsFilter = [("Text", "textformat.size.larger"), ("Price", "dollarsign"), ("Percent", "percent")]

    private var selectedArray: [(String, String)] = []

    // MARK: - Init with array type
    init(frame: CGRect = .zero, style: UITableView.Style = .plain, type: ListViewType) {
        super.init(frame: frame, style: style)
        delegate = self
        dataSource = self
        register(ListViewCell.self, forCellReuseIdentifier: ListViewCell.id)
        configureTableView()
        updateDataSource(with: type)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Update data source
    func updateDataSource(with type: ListViewType) {
        switch type {
        case .more:
            selectedArray = arrayForButtonsMore
        case .filter:
            selectedArray = arrayForButtonsFilter
        }
        reloadData()
    }
    
    func configureTableView() {
        backgroundColor = .white
        layer.cornerRadius = 20
        clipsToBounds = true
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        isScrollEnabled = false
    }
}

//MARK: - UITable View Delegate

extension ListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListViewCell.id,
                                                       for: indexPath) as? ListViewCell else {return UITableViewCell()}

        let text = selectedArray[indexPath.row]
        cell.configure(with: text.0, image: text.1)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listDelegate?.listView(self, didSelectItemAt: indexPath.row)
    }
}

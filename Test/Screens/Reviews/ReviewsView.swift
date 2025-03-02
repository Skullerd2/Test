import UIKit

final class ReviewsView: UIView {

    let tableView = UITableView()
    let activityIndicatorView = UIActivityIndicatorView()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = bounds.inset(by: safeAreaInsets)
    }

}

// MARK: - Private

private extension ReviewsView {

    func setupView() {
        backgroundColor = .systemBackground
        setupTableView()
        setupActivityIndicatorView()
    }

    func setupActivityIndicatorView(){
        addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func setupTableView() {
        addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(ReviewCell.self, forCellReuseIdentifier: ReviewCellConfig.reuseId)
        tableView.register(AmountCell.self, forCellReuseIdentifier: AmountCellConfig.reuseId)
    }

}

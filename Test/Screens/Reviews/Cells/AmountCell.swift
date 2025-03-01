import UIKit

struct AmountCellConfig {
    static let reuseId = String(describing: AmountCellConfig.self)
    /// Количество отзывов.
    var amountText: NSAttributedString
    
    fileprivate let layout = AmountCellLayout()
}

//MARK: - TableCellConfig

extension AmountCellConfig: TableCellConfig{
    func update(cell: UITableViewCell) {
        guard let cell = cell as? AmountCell else { return }
        cell.amountLabel.attributedText = amountText
        cell.config = self
    }
    
    func height(with size: CGSize) -> CGFloat {
        layout.height(config: self, maxWidth: size.width)
    }
}

final class AmountCell: UITableViewCell{
    fileprivate var config: Config?
    
    fileprivate var amountLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard let layout = config?.layout else { return }
        
        amountLabel.frame = layout.amountLabelFrame
    }
}

private extension AmountCell{
    func setupCell(){
        setumAmountLabel()
    }
    
    func setumAmountLabel(){
        contentView.addSubview(amountLabel)
    }
}

private final class AmountCellLayout{
    private(set) var amountLabelFrame = CGRect.zero
    
    func height(config: Config, maxWidth: CGFloat) -> CGFloat {
        
        let amountLabelSize = config.amountText.boundingRect(width: maxWidth).size
        let heightOfCell: CGFloat = 40
        amountLabelFrame = CGRect(
            origin: CGPoint(x: (maxWidth - amountLabelSize.width) / 2, y: (heightOfCell - amountLabelSize.height) / 2),
            size: amountLabelSize
        )
        return heightOfCell
    }

}

fileprivate typealias Config = AmountCellConfig

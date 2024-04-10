import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(_ number: Int) {
        self.label.text = number != 0 ? String(number) : ""
        switch number {
        case 2:
            self.contentView.backgroundColor = .twoColor
        case 4:
            self.contentView.backgroundColor = .fourColor
        case 8:
            self.contentView.backgroundColor = .eightColor
        case 16:
            self.contentView.backgroundColor = .sixteenColor
        case 32:
            self.contentView.backgroundColor = .thirtyTwoColor
        case 64:
            self.contentView.backgroundColor = .sixtyFourColor
        default:
            self.contentView.backgroundColor = .clear
        }
        self.setupUI()
    }
   
    private func setupUI() {
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.borderWidth = 1.5
        self.contentView.layer.borderColor = UIColor.black.cgColor
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

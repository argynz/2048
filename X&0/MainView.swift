import UIKit
import Const

class MainView{
    var score: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Score: 0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var bestScore: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Best score: 0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isUserInteractionEnabled = false
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private func setupSubviews(_ containerView: UIView) {
        containerView.addSubview(score)
        containerView.addSubview(bestScore)
        containerView.addSubview(collectionView)
    }
    
    private func setupConstraints(_ containerView: UIView) {
        NSLayoutConstraint.activate([
            score.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            score.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Const.labelsPadding),
            
            bestScore.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            bestScore.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Const.labelsPadding),
            
            collectionView.topAnchor.constraint(equalTo: score.bottomAnchor, constant: 20),
            collectionView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: Const.boardWidth),
            collectionView.heightAnchor.constraint(equalToConstant: Const.boardWidth),
        ])
    }
    
    func setupUI(_ containerView: UIView) {
        containerView.backgroundColor = .white
        
        setupSubviews(containerView)
        setupConstraints(containerView)
    }
}

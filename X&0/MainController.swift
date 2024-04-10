import UIKit
import Const

class MainController: UIViewController {
    private var mainView: MainView?
    private var numbers = Array(repeating: 0, count: 16)
    private var score = 0
    private var bestScore = 0
    
    private let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = MainView()
        bestScore = userDefaults.integer(forKey: "bestScore")
        mainView?.bestScore.text = "Best score: \(bestScore)"
        placeRandomTwo()
        mainView?.setupUI(view)
        setupNavBar()
        setupDelegats()
        setupTargets()
    }
    
    private func setupNavBar() {
        self.title = "2048"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "repeat"), style: .plain, target: self, action: #selector(barItemPressed))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    private func setupDelegats() {
        mainView?.collectionView.dataSource = self
        mainView?.collectionView.delegate = self
    }
    
    private func setupTargets() {
        addSwipeGestureRecognizer(direction: .right)
        addSwipeGestureRecognizer(direction: .left)
        addSwipeGestureRecognizer(direction: .up)
        addSwipeGestureRecognizer(direction: .down)
    }
    
    func addSwipeGestureRecognizer(direction: UISwipeGestureRecognizer.Direction) {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeGesture.direction = direction
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc func barItemPressed() {
        newGame()
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .right:
            moveTilesRight()
        case .left:
            moveTilesLeft()
        case .up:
            moveTilesUp()
        case .down:
            moveTilesDown()
        default:
            break
        }
    }
    
    private func moveTilesRight() {
        for row in 0..<4 {
            var tilesInRow = [Int]()
            for column in (0..<4).reversed() {
                let index = row * 4 + column
                tilesInRow.append(numbers[index])
            }
            mergeTiles(&tilesInRow)
            moveTiles(&tilesInRow)
            for column in 0..<4 {
                let index = row * 4 + column
                numbers[index] = tilesInRow.reversed()[column]
            }
        }
        updateBoard()
    }
    
    private func moveTilesUp() {
        for column in 0..<4 {
            var tilesInColumn = [Int]()
            for row in 0..<4 {
                let index = row * 4 + column
                tilesInColumn.append(numbers[index])
            }
            mergeTiles(&tilesInColumn)
            moveTiles(&tilesInColumn)
            for row in 0..<4 {
                let index = row * 4 + column
                numbers[index] = tilesInColumn[row]
            }
        }
        updateBoard()
    }

    private func moveTilesDown() {
        for column in 0..<4 {
            var tilesInColumn = [Int]()
            for row in (0..<4).reversed() {
                let index = row * 4 + column
                tilesInColumn.append(numbers[index])
            }
            mergeTiles(&tilesInColumn)
            moveTiles(&tilesInColumn)
            for row in 0..<4 {
                let index = row * 4 + column
                numbers[index] = tilesInColumn.reversed()[row]
            }
        }
        updateBoard()
    }

    private func moveTilesLeft() {
        for row in 0..<4 {
            var tilesInRow = [Int]()
            for column in 0..<4 {
                let index = row * 4 + column
                tilesInRow.append(numbers[index])
            }
            mergeTiles(&tilesInRow)
            moveTiles(&tilesInRow)
            for column in 0..<4 {
                let index = row * 4 + column
                numbers[index] = tilesInRow[column]
            }
        }
        updateBoard()
    }

    private func mergeTiles(_ tiles: inout [Int]) {
        tiles = tiles.filter { $0 != 0 }
        var index = 0
        while index < tiles.count - 1 {
            if tiles[index] == tiles[index + 1] {
                score += tiles[index]
                tiles[index] *= 2
                tiles.remove(at: index + 1)
                tiles.append(0)
            }
            index += 1
        }
    }

    private func moveTiles(_ tiles: inout [Int]) {
        tiles = tiles.filter { $0 != 0 }
        while tiles.count < 4 {
            tiles.append(0)
        }
    }

    private func placeRandomTwo() {
        if !numbers.contains(0) {
            gameOver()
        }
        let zeroIndices = numbers.indices.filter { numbers[$0] == 0 }
        if let randomIndex = zeroIndices.randomElement() {
            numbers[randomIndex] = 2
        }
    }
    
    private func updateBoard() {
        placeRandomTwo()
        mainView?.collectionView.reloadData()
        mainView?.score.text = "Score: \(score)"
        if score >= bestScore {
            bestScore = score
            userDefaults.set(bestScore, forKey: "bestScore")
            mainView?.bestScore.text = "Best score: \(bestScore)"
        }
    }
    
    private func newGame() {
        numbers = Array(repeating: 0, count: 16)
        score = 0
        updateBoard()
    }
    
    private func gameOver() {
        let alert = UIAlertController(title: "Game Over", message: "Your score is: \(score)", preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Try again", style: .default) { _ in
            self.newGame()
        }
        alert.addAction(alertButton)
        self.present(alert, animated: false)
    }
}

extension MainController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {
            fatalError("Error with cell")
        }
        cell.configure(self.numbers[indexPath.row])
        return cell
    }
}

extension MainController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = Const.cellWidth - 3
        return CGSize(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}


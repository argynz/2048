import UIKit

public struct Const{
    public static let screenWidth = UIScreen.main.bounds.width
    public static let boardWidth = UIScreen.main.bounds.width * 0.85
    public static let cellWidth = boardWidth / 4
    public static let labelsPadding = (screenWidth - boardWidth) / 2
}

public extension UIColor{
    static let twoColor = UIColor(red: 236/255.0, green: 230/255.0, blue: 218/255.0, alpha: 1)
    static let fourColor = UIColor(red: 235/255.0, green: 224/255.0, blue: 202/255.0, alpha: 1)
    static let eightColor = UIColor(red: 232/255.0, green: 180/255.0, blue: 130/255.0, alpha: 1)
    static let sixteenColor = UIColor(red: 231/255.0, green: 154/255.0, blue: 108/255.0, alpha: 1)
    static let thirtyTwoColor = UIColor(red: 229/255.0, green: 130/255.0, blue: 101/255.0, alpha: 1)
    static let sixtyFourColor = UIColor(red: 228/255.0, green: 103/255.0, blue: 71/255.0, alpha: 1)
    static let oneHundredColor = UIColor(red: 234/255.0, green: 209/255.0, blue: 127/255.0, alpha: 1)
    static let twoHundredColor = UIColor(red: 234/255.0, green: 205/255.0, blue: 113/255.0, alpha: 1)
    static let fiveHundredColor = UIColor(red: 230/255.0, green: 201/255.0, blue: 101/255.0, alpha: 1)
}

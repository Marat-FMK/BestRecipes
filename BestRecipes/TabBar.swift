//
//  tabinio.swift
//  BestRecipes
//
//  Created by Евгений Васильев on 12.08.2025.
//
//import UIKit
//import Foundation
//
//class TabBarViewController : UITabBarController {
//    let btnMiddle : UIButton = {
//        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
//        btn.layer.cornerRadius = 30
//        btn.layer.shadowColor = UIColor.black.cgColor
//        btn.layer.shadowOpacity = 0.2
//        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
//        btn.setBackgroundImage(UIImage(named: "create"), for: .normal)
//        return btn
//    }()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        addSomeTabItems()
//        btnMiddle.frame = CGRect(x: Int(self.tabBar.bounds.width)/2 - 30, y: -20, width: 60, height: 60)
//    }
//    override func loadView() {
//        super.loadView()
//        self.tabBar.addSubview(btnMiddle)
//        setupCustomTabBar()
//    }
//    func setupCustomTabBar() {
//        let path : UIBezierPath = getPathForTabBar()
//        let shape = CAShapeLayer()
//        shape.path = path.cgPath
//        shape.lineWidth = 3
//        shape.strokeColor = UIColor.white.cgColor
//        shape.fillColor = UIColor.white.cgColor
//        shape.shadowColor = UIColor.black.cgColor
//        shape.shadowOffset = CGSize(width: 0, height: -3)
//        shape.shadowOpacity = 0.3
//        shape.shadowRadius = 5
//        self.tabBar.layer.insertSublayer(shape, at: 0)
//        self.tabBar.itemWidth = 50
//        self.tabBar.itemPositioning = .centered
//        self.tabBar.itemSpacing = 20
//    }
//    
//    func addSomeTabItems() {
//        let vc1 = UINavigationController(rootViewController: WelcomeViewController())
//        let vc2 = UINavigationController(rootViewController: OnboarbingViewController())
//        let emptyVC3 = UIViewController()
//        let emptyVC4 = UIViewController()
//        setViewControllers([vc1, vc2, emptyVC3, emptyVC4], animated: false)
//        guard let items = tabBar.items else { return}
//        items[0].image = UIImage(named: "navIntactive")
//        items[1].image = UIImage(named: "bookMarkInactive")
//        items[2].image = UIImage(named: "notificationInactive")
//        items[3].image = UIImage(named: "profileInactive")
//    }
//    
//    func getPathForTabBar() -> UIBezierPath {
//        let frameWidth = self.tabBar.bounds.width
//        let frameHeight = self.tabBar.bounds.height + 60
//        let holeWidth = 150
//        let holeHeight = 50
//        let leftXUntilHole = Int(frameWidth/2) - Int(holeWidth/2)
//        
//        let path : UIBezierPath = UIBezierPath()
//        path.move(to: CGPoint(x: 0, y: 0))
//        path.addLine(to: CGPoint(x: leftXUntilHole , y: 0)) // 1.Line
//        path.addCurve(to: CGPoint(x: leftXUntilHole + (holeWidth/3), y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*6,y: 0), controlPoint2: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*8, y: holeHeight/2)) // part I
//        
//        path.addCurve(to: CGPoint(x: leftXUntilHole + (2*holeWidth)/3, y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2/5, y: (holeHeight/2)*6/4), controlPoint2: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2 + (holeWidth/3)/3*3/5, y: (holeHeight/2)*6/4)) // part II
//        
//        path.addCurve(to: CGPoint(x: leftXUntilHole + holeWidth, y: 0), controlPoint1: CGPoint(x: leftXUntilHole + (2*holeWidth)/3,y: holeHeight/2), controlPoint2: CGPoint(x: leftXUntilHole + (2*holeWidth)/3 + (holeWidth/3)*2/8, y: 0)) // part III
//        path.addLine(to: CGPoint(x: frameWidth, y: 0)) // 2. Line
//        path.addLine(to: CGPoint(x: frameWidth, y: frameHeight)) // 3. Line
//        path.addLine(to: CGPoint(x: 0, y: frameHeight)) // 4. Line
//        path.addLine(to: CGPoint(x: 0, y: 0)) // 5. Line
//        path.close()
//        return path
//    }
//}
//
//extension UIColor {
//    public convenience init?(hex: String, alpha: Double = 1.0) {
//        var pureString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
//        if (pureString.hasPrefix("#")) {
//            pureString.remove(at: pureString.startIndex)
//        }
//        if ((pureString.count) != 6) {
//            return nil
//        }
//        let scanner = Scanner(string: pureString)
//        var hexNumber: UInt64 = 0
//        
//        if scanner.scanHexInt64(&hexNumber) {
//            self.init(
//                red: CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0,
//                green: CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0,
//                blue: CGFloat(hexNumber & 0x0000FF) / 255.0,
//                alpha: CGFloat(1.0))
//            return
//        }
//        return nil
//    }
//}
//

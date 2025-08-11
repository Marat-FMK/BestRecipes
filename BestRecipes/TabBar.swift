//
//  TabBar.swift
//  BestRecipes
//
//  Created by Евгений Васильев on 12.08.2025.
//
import UIKit
import Foundation

class TabBar : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: OnboarbingViewController(),
                image: UIImage(named: "navIntactive"),
                selectedImage: UIImage(named: "navActive")),
            generateVC(
                viewController: WelcomeViewController(),
                image: UIImage(named: "create"),
                selectedImage: UIImage(named: "create")),
            generateVC(
                viewController: HomeViewController(),
                image: UIImage(named: "navIntactive"),
                selectedImage: UIImage(named: "navActive"))
        ]
    }
    
    private func generateVC(viewController : UIViewController, image : UIImage?, selectedImage : UIImage?) -> UIViewController {
        var configuredImage = image
        var configuredSelectedImage = selectedImage
        if let image = image {
               configuredImage = image.withRenderingMode(.alwaysOriginal)
           }
        if let selectedImage = selectedImage {
               configuredSelectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
           }
        viewController.tabBarItem = UITabBarItem(
               title: nil,
               image: configuredImage,
               selectedImage: configuredSelectedImage
           )
        return viewController
    }
    
    private func setTabBarAppearance() {
        
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.isTranslucent = true
        let backgroundView = UIImageView(image: UIImage(named: "backGroundBar"))
        backgroundView.contentMode = .scaleToFill
        backgroundView.frame = tabBar.bounds
        backgroundView.clipsToBounds = true
        backgroundView.frame = CGRect(
                x: -10,
                y: 0,
                width: tabBar.bounds.width + 20,
                height: tabBar.bounds.height + 40
            )
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabBar.insertSubview(backgroundView, at: 0)
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = 20
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .clear
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
    }
    
    
}

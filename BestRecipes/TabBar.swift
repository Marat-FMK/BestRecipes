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
                viewController: WelcomeViewController(),
                image: UIImage(named: "navActive")),
            generateVC(
                viewController: OnboarbingViewController(),
                image: UIImage(named: "navActive"))
        ]
    }
    
    private func generateVC(viewController : UIViewController, image : UIImage?) -> UIViewController {
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setTabBarAppearance() {
        
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage() // Убираем разделительную линию
        
        // 2. Создаем кастомное view для фона
        let backgroundView = UIImageView(image: UIImage(named: "backGroundBar"))
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.frame = tabBar.bounds
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // 3. Добавляем его под стандартные элементы
        tabBar.insertSubview(backgroundView, at: 0)
        
        // 4. Корректируем позицию иконок
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = 20
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
    }
    
    
}

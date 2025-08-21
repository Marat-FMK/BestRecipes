//
//  TabBarVC.swift
//  BestRecipes
//
//  Created by Евгений Васильев on 12.08.2025.
//
import UIKit
import Foundation

class TabBarViewController : UITabBarController {
    
    private let customTabBar = TabBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupCustomTabBar()
    }
    
    func setupCustomTabBar() {
        tabBar.isHidden = true
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customTabBar)
        
        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            customTabBar.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        customTabBar.homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        customTabBar.bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        customTabBar.notificationButton.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
        customTabBar.profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        customTabBar.createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        selectedIndex = 0
        updateButtonSelection()
    }
    
    private func setupViewControllers() {
        let homeVC = HomeViewController()
        let bookmarksVC = DiscoverViewController()
        let notificationsVC = UIViewController()
        let profileVC = UIViewController()

        
        viewControllers = [
            UINavigationController(rootViewController: homeVC),
            UINavigationController(rootViewController: bookmarksVC),
            UINavigationController(rootViewController: notificationsVC),
            UINavigationController(rootViewController: profileVC)
        ]
    }
    
    @objc private func homeButtonTapped(sender : UIButton) {
        sender.buttonTappedAnimate()
        selectedIndex = 0
        updateButtonSelection()
    }
    
    @objc private func bookmarkButtonTapped(sender : UIButton) {
        sender.buttonTappedAnimate()
        selectedIndex = 1
        updateButtonSelection()
    }
    
    @objc private func notificationButtonTapped(sender : UIButton) {
        sender.buttonTappedAnimate()
        selectedIndex = 2
        updateButtonSelection()
    }
    
    @objc private func profileButtonTapped(sender : UIButton) {
        sender.buttonTappedAnimate()
        selectedIndex = 3
        updateButtonSelection()
    }
    
    @objc private func createButtonTapped(sender : UIButton) {
        sender.buttonTappedAnimate()
    }
    
    private func updateButtonSelection() {
        customTabBar.homeButton.isSelected = (selectedIndex == 0)
        customTabBar.bookmarkButton.isSelected = (selectedIndex == 1)
        customTabBar.notificationButton.isSelected = (selectedIndex == 2)
        customTabBar.profileButton.isSelected = (selectedIndex == 3)
    }
}



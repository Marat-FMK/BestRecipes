//
//  TabBarView.swift
//  BestRecipes
//
//  Created by Евгений Васильев on 12.08.2025.
//
import UIKit

class TabBarView : UIView {
    
    let homeButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.Images.homeButtonImageInactive), for: .normal)
        button.setImage(UIImage(named: Constants.Images.homeButtonImageActive), for: .selected)
        return button
    }()
    
    let bookmarkButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.Images.bookmarkButtonImageInactive), for: .normal)
        button.setImage(UIImage(named: Constants.Images.bookmarkButtonImageActive), for: .selected)
        return button
    }()
    
    let createButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.Images.createButtonImage), for: .normal)
        return button
    }()
    
    let notificationButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.Images.notificationButtonImageInactive), for: .normal)
        button.setImage(UIImage(named: Constants.Images.notificationButtonImageActive), for: .selected)
        return button
    }()
    
    let profileButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.Images.profileButtonImageInactive), for: .normal)
        button.setImage(UIImage(named: Constants.Images.profileButtonImageActive), for: .selected)
        return button
    }()
    
    let backgroundImage : UIView = {
        let view = UIImageView()
        view.image = UIImage(named: Constants.Images.backgroundBarImage)
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(backgroundImage)
        addSubview(homeButton)
        addSubview(bookmarkButton)
        addSubview(createButton)
        addSubview(notificationButton)
        addSubview(profileButton)
        addShadow()
    }
    
    func selectTab(at index: Int) {
        homeButton.isSelected = (index == 0)
        bookmarkButton.isSelected = (index == 1)
        notificationButton.isSelected = (index == 2)
        profileButton.isSelected = (index == 3)
    }
    
    func setConstraints() {
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor,constant: -10),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor,constant: 5),
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
        ])
        
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeButton.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 20),
            homeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            homeButton.heightAnchor.constraint(equalToConstant: 40),
            homeButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookmarkButton.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 20),
            bookmarkButton.leadingAnchor.constraint(equalTo: homeButton.trailingAnchor, constant: 40),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 40),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        createButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: -20),
            createButton.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
        ])
        
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileButton.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 20),
            profileButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            profileButton.heightAnchor.constraint(equalToConstant: 40),
            profileButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        notificationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notificationButton.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 20),
            notificationButton.trailingAnchor.constraint(equalTo: profileButton.leadingAnchor, constant: -40),
            notificationButton.heightAnchor.constraint(equalToConstant: 40),
            notificationButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
        self.layer.cornerRadius = 12
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
    
}

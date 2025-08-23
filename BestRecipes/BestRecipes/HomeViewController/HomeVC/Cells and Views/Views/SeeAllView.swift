//
//  SeeAllView.swift
//  BestRecipes
//
//  Created by Евгений Васильев on 12.08.2025.
//
import UIKit

class SeeAllView : UIView {
    
    let seeAllButton : UIButton = {
        let button = UIButton()
        button.setTitle("See all", for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.Fonts.poppinsRegular, size: 14)
        button.setTitleColor(UIColor.primary50, for: .normal)
        return button
    }()
    
    let arrowRightIcon : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Constants.Images.arrowRightImage)
        view.contentMode = .scaleAspectFit
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
        addSubview(seeAllButton)
        addSubview(arrowRightIcon)
    }
    
    func setConstraints() {
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            seeAllButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            seeAllButton.widthAnchor.constraint(equalToConstant: 50),
            seeAllButton.topAnchor.constraint(equalTo: topAnchor),
            seeAllButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
 
        arrowRightIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrowRightIcon.trailingAnchor.constraint(equalTo: trailingAnchor),
            arrowRightIcon.topAnchor.constraint(equalTo: topAnchor),
            arrowRightIcon.bottomAnchor.constraint(equalTo: bottomAnchor),
            arrowRightIcon.leadingAnchor.constraint(equalTo: seeAllButton.trailingAnchor, constant: 3),
            arrowRightIcon.widthAnchor.constraint(equalToConstant: 10),
            arrowRightIcon.widthAnchor.constraint(equalToConstant: 10)
        ])
    }
    
}


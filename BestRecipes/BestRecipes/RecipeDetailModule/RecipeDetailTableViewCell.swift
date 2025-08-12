//
//  RecipeDetailTableViewCell.swift
//  BestRecipes
//
//  Created by Aliaksandr Zuyeu on 12.08.25.
//

import UIKit

class RecipeDetailTableViewCell: UITableViewCell {
    
    static let identifier = "RecipeDetailCell"
    
    private let ingredientImage: UIImageView = {
        let ingredientImage = UIImageView()
        ingredientImage.translatesAutoresizingMaskIntoConstraints = false
        return ingredientImage
    }()
    
    private let ingredientLabel: UILabel = {
        let ingridientLabel = UILabel()
        ingridientLabel.font = UIFont(name: Constants.Fonts.poppinsBold, size: 20)
        ingridientLabel.translatesAutoresizingMaskIntoConstraints = false
        return ingridientLabel
    }()
    
    private let ingredientWeightLabel: UILabel = {
        let ingredientWeightLabel = UILabel()
        ingredientWeightLabel.font = UIFont(name: Constants.Fonts.poppinsRegular, size: 20)
        ingredientWeightLabel.textColor = Constants.Colors.Neutral.neutral50
        ingredientWeightLabel.translatesAutoresizingMaskIntoConstraints = false
        return ingredientWeightLabel
    }()
    
    private let ingredientCheckBox: UIButton = {
        let ingredientCheckBox = UIButton()
        ingredientCheckBox.setImage(UIImage(named: Constants.Icons.tickCircleInactive), for: .normal)
        ingredientCheckBox.setImage(UIImage(named: Constants.Icons.tickCircleActive), for: .selected)
        ingredientCheckBox.translatesAutoresizingMaskIntoConstraints = false
        return ingredientCheckBox
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        self.contentView.layer.cornerRadius = 12
        self.contentView.backgroundColor = Constants.Colors.Neutral.neutral10
        
        self.contentView.addSubview(ingredientImage)
        NSLayoutConstraint.activate([
            ingredientImage.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor, constant: 12),
            ingredientImage.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor, constant: 16),
            ingredientImage.widthAnchor.constraint(equalToConstant: 52),
            ingredientImage.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        self.contentView.addSubview(ingredientLabel)
        NSLayoutConstraint.activate([
            ingredientLabel.centerYAnchor.constraint(equalTo: ingredientImage.centerYAnchor),
            ingredientLabel.leadingAnchor.constraint(equalTo: ingredientImage.trailingAnchor, constant: 24),
            ingredientLabel.widthAnchor.constraint(equalToConstant: 124),
            ingredientLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        self.contentView.addSubview(ingredientWeightLabel)
        NSLayoutConstraint.activate([
            ingredientWeightLabel.centerYAnchor.constraint(equalTo: ingredientImage.centerYAnchor),
            ingredientWeightLabel.leadingAnchor.constraint(equalTo: ingredientLabel.trailingAnchor, constant: 24),
            ingredientWeightLabel.trailingAnchor.constraint(equalTo: ingredientCheckBox.leadingAnchor),
            ingredientWeightLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        self.contentView.addSubview(ingredientCheckBox)
        NSLayoutConstraint.activate([
            ingredientCheckBox.centerYAnchor.constraint(equalTo: ingredientImage.centerYAnchor),
            ingredientCheckBox.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor, constant: -16),
            ingredientCheckBox.widthAnchor.constraint(equalToConstant: 23.5),
            ingredientCheckBox.heightAnchor.constraint(equalToConstant: 23.5)
        ])
    }
}


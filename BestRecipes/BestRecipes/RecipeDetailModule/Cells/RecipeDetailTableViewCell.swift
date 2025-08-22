//
//  RecipeDetailTableViewCell.swift
//  BestRecipes
//
//  Created by Aliaksandr Zuyeu on 12.08.25.
//

import UIKit
import SDWebImage

class RecipeDetailTableViewCell: UITableViewCell {
    
    static let identifier = "RecipeDetailCell"
    
    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = Constants.Colors.Neutral.neutral10
        return view
    }()
    
    private let ingredientImage: UIImageView = {
        let ingredientImage = UIImageView()
        ingredientImage.image = UIImage(named: "cucumber")
        ingredientImage.translatesAutoresizingMaskIntoConstraints = false
        return ingredientImage
    }()
    
    private let ingredientLabel: UILabel = {
        let ingredientLabel = UILabel()
        ingredientLabel.font = UIFont(name: Constants.Fonts.poppinsSemiBold, size: 16)
        ingredientLabel.text = "Cucumberjnojn onjjo ojnojnon onoj"
        ingredientLabel.numberOfLines = 0
        ingredientLabel.lineBreakMode = .byWordWrapping
        ingredientLabel.translatesAutoresizingMaskIntoConstraints = false
        return ingredientLabel
    }()
    
    private let ingredientWeightLabel: UILabel = {
        let ingredientWeightLabel = UILabel()
        ingredientWeightLabel.font = UIFont(name: Constants.Fonts.poppinsRegular, size: 14)
        ingredientWeightLabel.textColor = Constants.Colors.Neutral.neutral50
        ingredientWeightLabel.text = "200g"
        ingredientWeightLabel.textAlignment = .center
        ingredientWeightLabel.lineBreakMode = .byWordWrapping
        ingredientWeightLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientWeightLabel.numberOfLines = 0
        return ingredientWeightLabel
    }()
    
    private let ingredientCheckBox: UIButton = {
        let ingredientCheckBox = UIButton()
        ingredientCheckBox.translatesAutoresizingMaskIntoConstraints = false
        ingredientCheckBox.setImage(UIImage(named: Constants.Icons.tickCircleInactive), for: .normal)
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
        self.contentView.addSubview(cellView)
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6.5),
            cellView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6.5)
        ])
        
        cellView.addSubview(ingredientImage)
        NSLayoutConstraint.activate([
            ingredientImage.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 12),
            ingredientImage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 16),
            ingredientImage.bottomAnchor.constraint(equalTo: cellView.bottomAnchor,constant: -12),
            ingredientImage.widthAnchor.constraint(equalToConstant: 52)
        ])
        
        cellView.addSubview(ingredientLabel)
        NSLayoutConstraint.activate([
            ingredientLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 12),
            ingredientLabel.leadingAnchor.constraint(equalTo: ingredientImage.trailingAnchor, constant: 24),
            ingredientLabel.widthAnchor.constraint(equalToConstant: 124),
            ingredientLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -12)
        ])
        
        cellView.addSubview(ingredientWeightLabel)
        NSLayoutConstraint.activate([
            ingredientWeightLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 12),
            ingredientWeightLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -12),
            ingredientWeightLabel.leadingAnchor.constraint(equalTo: ingredientLabel.trailingAnchor)
        ])
        
        cellView.addSubview(ingredientCheckBox)
        NSLayoutConstraint.activate([
            ingredientCheckBox.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 26),
            ingredientCheckBox.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -19),
            ingredientCheckBox.bottomAnchor.constraint(equalTo:cellView.bottomAnchor, constant: -26),
            ingredientCheckBox.widthAnchor.constraint(equalToConstant: 23.5),
            ingredientCheckBox.heightAnchor.constraint(equalToConstant: 23.5),
            ingredientWeightLabel.trailingAnchor.constraint(equalTo: ingredientCheckBox.leadingAnchor, constant: -27),
        ])
        ingredientCheckBox.addTarget(self, action: #selector(checkPressed) , for: .touchUpInside)
    }
    
    @objc private func checkPressed(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            sender.setImage(UIImage(named: Constants.Icons.tickCircleActive), for: .normal)
        } else {
            sender.setImage(UIImage(named: Constants.Icons.tickCircleInactive), for: .normal)
        }
    }
    func configure(with recipe: RecipeDetail, counter: Int) {
        
        let baseLink = "https://img.spoonacular.com/ingredients_100x100/" + recipe.extendedIngredients[counter].image
        
        ingredientImage.sd_setImage(
            with: URL(string: baseLink),
            placeholderImage: UIImage(named: "placeholderIngredient"),
            options: [.progressiveLoad, .highPriority]
        )
        
        ingredientLabel.text = recipe.extendedIngredients[counter].name
        ingredientWeightLabel.text = String(format: "%.2f", recipe.extendedIngredients[counter].amount) + " " +  String(recipe.extendedIngredients[counter].unit)
    }
}


//
//  InstructionsCell.swift
//  BestRecipes
//
//  Created by Aliaksandr Zuyeu on 14.08.25.
//

import UIKit

class RecipeDetailAboutCell: UITableViewCell {
    
    static let identifier = "RecipeDetailAbout"
    
    private let topHeader: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.font = UIFont(name: Constants.Fonts.poppinsBold, size: 24)
            label.text = "How to make How to makeHow to makeHow to makeHow to makeHow to makeHow to makeHow to makeHow to makeHow to makeHow to makeHow to makeHow to makeHow to make"
            return label
        }()
    
    //MARK: Dish Image
    private let dishImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    //MARK: Reviews Section Items
    private let reviewsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    private let reviewsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Constants.Icons.star)
        return imageView
    }()
    
    private let recipeRating: UILabel = {
        let recipeRating = UILabel()
        recipeRating.translatesAutoresizingMaskIntoConstraints = false
        recipeRating.font = UIFont(name: Constants.Fonts.poppinsSemiBold, size: 14)
        recipeRating.text = "4.5"
        return recipeRating
    }()
    
    private let countOfReviews: UILabel = {
        let countLabel = UILabel()
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.font = UIFont(name: Constants.Fonts.poppinsRegular, size: 14)
        countLabel.textColor = Constants.Colors.Neutral.neutral50
        countLabel.text = "(Reviews)"
        return countLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6.5, left: 0, bottom: 6.5, right: 0))
    }
    
    private func setupUI() {
        
        //MARK: TopHeader UI
        self.contentView.addSubview(topHeader)
        NSLayoutConstraint.activate([
            topHeader.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            topHeader.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            topHeader.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
        
        //MARK: DishImage UI
        self.contentView.addSubview(dishImage)
        NSLayoutConstraint.activate([
            dishImage.topAnchor.constraint(equalTo: topHeader.bottomAnchor, constant: 13),
            dishImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            dishImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            dishImage.heightAnchor.constraint(equalToConstant: 200)
        ])
        dishImage.backgroundColor = .red
        
        //MARK: Rating Section UI
        self.contentView.addSubview(reviewsStack)
        NSLayoutConstraint.activate([
            reviewsStack.topAnchor.constraint(equalTo: dishImage.bottomAnchor, constant: 13),
            reviewsStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            reviewsStack.heightAnchor.constraint(equalToConstant: 20),
            reviewsStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        reviewsStack.addArrangedSubview(reviewsImage)
        reviewsStack.addArrangedSubview(recipeRating)
        reviewsStack.addArrangedSubview(countOfReviews)
    }
    
    //    func configure(with ingredient: Ingredient) {
    //        ingredientImage.image = UIImage(named: ingredient.imageName)
    //        ingredientLabel.text = ingredient.name
    //        ingredientWeightLabel.text = ingredient.weight
    //        ingredientCheckBox.isSelected = ingredient.isChecked
    //    }
}

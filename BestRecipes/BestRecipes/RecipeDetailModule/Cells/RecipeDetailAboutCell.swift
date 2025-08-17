//
//  InstructionsCell.swift
//  BestRecipes
//
//  Created by Aliaksandr Zuyeu on 14.08.25.
//

import UIKit
import SDWebImage

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
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
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
    
    private func setupUI() {
        
        //MARK: TopHeader UI
        self.contentView.addSubview(topHeader)
        NSLayoutConstraint.activate([
            topHeader.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant:  6.5),
            topHeader.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            topHeader.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
        
        //MARK: DishImage UI
        self.contentView.addSubview(dishImage)
        NSLayoutConstraint.activate([
            dishImage.topAnchor.constraint(equalTo: topHeader.bottomAnchor, constant: 13),
            dishImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            dishImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            dishImage.heightAnchor.constraint(equalToConstant: 200)
        ])
//        dishImage.backgroundColor = .red
        dishImage.sd_setImage(
            with: URL(string: "https://img.spoonacular.com/recipes/716429-556x370.jpg"),
            placeholderImage: UIImage(named: "placeholder"),
            options: [.progressiveLoad, .highPriority]
        )
        
        
        //MARK: Rating Section UI
        self.contentView.addSubview(reviewsStack)
        NSLayoutConstraint.activate([
            reviewsStack.topAnchor.constraint(equalTo: dishImage.bottomAnchor, constant: 13),
            reviewsStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            reviewsStack.heightAnchor.constraint(equalToConstant: 20),
            reviewsStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant:  -6.5)
        ])
        reviewsStack.addArrangedSubview(reviewsImage)
        reviewsStack.addArrangedSubview(recipeRating)
        reviewsStack.addArrangedSubview(countOfReviews)
    }
    
        func configure(with recipe: RecipeDetail) {
            self.topHeader.text = recipe.title
            dishImage.sd_setImage(
                with: URL(string: recipe.image),
                placeholderImage: UIImage(named: "placeholderDish"),
                options: [.progressiveLoad, .highPriority]
            )
        }
}

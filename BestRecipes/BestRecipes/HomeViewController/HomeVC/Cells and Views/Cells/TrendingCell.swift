//
//  TrendingCell.swift
//  BestRecipes
//
//  Created by Евгений Васильев on 12.08.2025.
//
import UIKit

class TrendingCell: UICollectionViewCell {
    
    var storageManager = StorageManager()
    
    let backgroundImageView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "shawarma_image")
        view.layer.cornerRadius = 12
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "How to shawarma at home"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    let ratingView : RatingView = {
        let view = RatingView()
        return view
    }()
    
    let saveButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.Images.bookmarkButtonImageInactive), for: .normal)
        button.backgroundColor = .white0
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let creatorImageView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "creatorImage")
        return view
    }()
    
    let creatorLabel : UILabel = {
        let label = UILabel()
        label.text = "By Zeelicious foods"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .left
        label.textColor = .neutral50
        return label
    }()
    
    //MARK: - Save Func
    
    @objc func saveButtonTapped(sender: UIButton) {
        sender.buttonTappedAnimate()
//        let recepie = RecipeDetail?.self
//            if recepie.isFavorite == true {
//                storageManager.deleteFavoriteRecipe(recipe: recepie)
//            } else {
//                storageManager.saveFavoriteRecipe(recipe: recepie)
//            }
    }
    
    //MARK: - Setup
    
    let identifier = "TrendingCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingView)
        contentView.addSubview(saveButton)
        contentView.addSubview(creatorImageView)
        contentView.addSubview(creatorLabel)
    }
    
    private func setConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -70)
        ])
        
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratingView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 8),
            ratingView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 8),
            ratingView.heightAnchor.constraint(equalToConstant: 30),
            ratingView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 8),
            saveButton.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -8),
            saveButton.heightAnchor.constraint(equalToConstant: 32),
            saveButton.widthAnchor.constraint(equalToConstant: 32)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        creatorImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            creatorImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            creatorImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
        
        creatorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            creatorLabel.centerYAnchor.constraint(equalTo: creatorImageView.centerYAnchor),
            creatorLabel.leadingAnchor.constraint(equalTo: creatorImageView.trailingAnchor, constant: 8)
        ])
        
        
    }
    
    
    
    // Marat
    func configure(with recipe: RecipeDetail) {
        titleLabel.text = recipe.title
        creatorLabel.text = "By \(recipe.sourceName)"
        
        if let url = URL(string: recipe.image) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.backgroundImageView.image = image
                    }
                }
            }
        } else {
            backgroundImageView.image = UIImage(named: "placeholder")
        }
        
        ratingView.setRating(rating: recipe.spoonacularScore)
        
        let imageName = recipe.isFavorite ? Constants.Images.bookmarkButtonImageActive : Constants.Images.bookmarkButtonImageInactive
        saveButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    
    
    
}



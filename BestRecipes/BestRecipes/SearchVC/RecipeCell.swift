//
//  RecipeCell.swift
//  BestRecipes
//
//  Created by Сергей on 12.08.2025.
//

import UIKit


class RecipeCell: UITableViewCell {
    
    static let identifier = "RecipeCell"
    
    private let recipeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 12
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.6).cgColor]
        gradient.locations = [0.5, 1.0]
        iv.layer.addSublayer(gradient)
        
        print("create")
        print("\(iv.bounds)")

        DispatchQueue.main.async {
            gradient.frame = iv.bounds
            print("4")
            print("\(iv.bounds)")
        }
        
        return iv
    }()

    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont(name: "Poppins-Bold", size: 16)
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let subtitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont(name: "Poppins-Regular", size: 12)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let ratingView: RatingView = {
        let view = RatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Setup UI
    private func setupUI() {
        contentView.addSubview(recipeImageView)
        contentView.addSubview(ratingView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            recipeImageView.heightAnchor.constraint(equalToConstant: 200),
            recipeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            ratingView.topAnchor.constraint(equalTo: recipeImageView.topAnchor, constant: 8),
            ratingView.leadingAnchor.constraint(equalTo: recipeImageView.leadingAnchor, constant: 8),
            ratingView.widthAnchor.constraint(equalToConstant: 60),
            ratingView.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.leadingAnchor.constraint(equalTo: recipeImageView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -4),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: recipeImageView.leadingAnchor, constant: 12),
            subtitleLabel.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: -12),
            subtitleLabel.bottomAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: -8)
        ])
        print("1")
        print("\(recipeImageView.bounds)")

    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !recipeImageView.layer.sublayers!.contains(where: { $0 is CAGradientLayer }) {
            let gradient = CAGradientLayer()
            gradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.6).cgColor]
            gradient.locations = [0.5, 1.0]
            recipeImageView.layer.insertSublayer(gradient, at: 0)
        }
        
        // Обновляем frame градиента
        if let gradient = recipeImageView.layer.sublayers?.first(where: { $0 is CAGradientLayer }) as? CAGradientLayer {
            gradient.frame = recipeImageView.bounds
        }
    }
    
    // MARK: - Configure
    func configure(with recipe: Recipe) {
        recipeImageView.image = UIImage(named: recipe.imageName)
        titleLabel.text = recipe.title
        subtitleLabel.text = "\(recipe.ingredients) | \(recipe.time)"
        print("3")
        print("\(recipeImageView.bounds)")
    }

    
}


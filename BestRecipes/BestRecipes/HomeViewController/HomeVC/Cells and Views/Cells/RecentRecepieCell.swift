//
//  RecentRecepie.swift
//  BestRecipes
//
//  Created by Евгений Васильев on 12.08.2025.
//
import UIKit

class RecentRecepieCell: UICollectionViewCell {
    
    let backgroundImageView : UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 12
        view.image = UIImage(named: "recentRecepieImage")
        return view
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Kelewele\nGhanian Recipe"
        label.numberOfLines = 1
        label.font = UIFont(name: Constants.Fonts.poppinsSemiBold, size: 14)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    let creatorLabel : UILabel = {
        let label = UILabel()
        label.text = "by Zeelicious Food"
        label.numberOfLines = 1
        label.font = UIFont(name: Constants.Fonts.poppinsRegular, size: 10)
        label.textAlignment = .left
        label.textColor = .neutral40
        return label
    }()
    
    
    let identifier = "RecentPecepieCell"
    
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
        contentView.addSubview(creatorLabel)
    }
    
    func configure(with recipe: RecipeDetail) {
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
        titleLabel.text = recipe.title
        creatorLabel.text = recipe.sourceName
    }
    
    private func setConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 124)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        creatorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            creatorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            creatorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
        
    }
}





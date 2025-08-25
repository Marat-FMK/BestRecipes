//
//  CuisineTableViewCell.swift
//  BestRecipes
//
//  Created by Aliaksandr Zuyeu on 24.08.25.
//

import UIKit
import SDWebImage

class CuisineTableViewCell: UITableViewCell {
    
    static let identifier = "CuisineCell"
    
    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = Constants.Colors.Neutral.neutral10
        return view
    }()
    
    private let cellImage: UIImageView = {
        let cellImage = UIImageView()
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        cellImage.image = UIImage(named: "cucumber")
        cellImage.contentMode = .scaleAspectFit
        return cellImage
    }()
    
    private let cellLabel: UILabel = {
        let cellLabel = UILabel()
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.font = UIFont(name: Constants.Fonts.poppinsSemiBold, size: 16)
        cellLabel.text = "Cucumberjnojn onjjo ojnojnon onoj"
        cellLabel.numberOfLines = 0
        cellLabel.lineBreakMode = .byWordWrapping
        return cellLabel
    }()
    private var cellLabelTrailingToView: NSLayoutConstraint?
    
    private let arrowRightImage: UIImageView = {
        let arrowRightImage = UIImageView()
        arrowRightImage.translatesAutoresizingMaskIntoConstraints = false
        arrowRightImage.image = UIImage(systemName: "chevron.right")
        arrowRightImage.tintColor = Constants.Colors.Neutral.neutral30
        arrowRightImage.contentMode = .scaleAspectFit
        return arrowRightImage
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUIWithRightButtonImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.contentView.addSubview(cellView)
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            cellView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        ])
        
        cellView.addSubview(cellImage)
        NSLayoutConstraint.activate([
            cellImage.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 8),
            cellImage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 16),
            cellImage.bottomAnchor.constraint(equalTo: cellView.bottomAnchor,constant: -8),
            cellImage.widthAnchor.constraint(equalToConstant: 60),
            cellImage.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        cellView.addSubview(cellLabel)
        cellLabelTrailingToView = cellLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -16)
        cellLabelTrailingToView?.isActive = true
        NSLayoutConstraint.activate([
            cellLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 8),
            cellLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 24),
            cellLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupUIWithRightButtonImage() {
        self.setupUI()
        cellView.addSubview(arrowRightImage)
        cellLabelTrailingToView?.isActive = false
        NSLayoutConstraint.activate([
            arrowRightImage.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 8),
            arrowRightImage.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            arrowRightImage.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -8),
            arrowRightImage.widthAnchor.constraint(equalToConstant: 15),
            cellLabel.trailingAnchor.constraint(equalTo: arrowRightImage.leadingAnchor)
        ])
    }
    
    func configureForRecipes(with cuisineRecipe: RecipeDetail) {
        self.setupUI()
        self.cellLabel.text = cuisineRecipe.title
        self.cellImage.sd_setImage(
            with: URL(string: cuisineRecipe.image),
            placeholderImage: UIImage(named: "placeholderDish"),
            options: [.progressiveLoad, .highPriority]
        )
    }
    
    func configureForCuisine(cuisineName: String, cuisineImage: UIImage) {
        self.setupUIWithRightButtonImage()
        self.cellLabel.text = cuisineName
        self.cellImage.image = cuisineImage
    }
}


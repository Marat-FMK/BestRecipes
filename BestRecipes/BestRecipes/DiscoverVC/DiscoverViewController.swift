//
//  DiscoverViewController.swift
//  BestRecipes
//
//  Created by Rustam Basanov on 18.08.2025.
//

import UIKit

struct Recipe {
    let image: String
    let title: String
    let author: String
    let rating: String
    let duration: String
}

class RecipeCell: UICollectionViewCell {
    static let identifier = "RecipeCell"
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    
    private let ratingLabel = UILabel()
    private let bookmarkButton = UIButton(type: .system)
    private let durationLabel = UILabel()
    
    private var isBookmarked = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowRadius = 5
        contentView.clipsToBounds = true
        
        // --- Image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        contentView.addSubview(imageView)
        
        // --- Title
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 2
        contentView.addSubview(titleLabel)
        
        // --- Author
        authorLabel.font = .systemFont(ofSize: 14)
        authorLabel.textColor = .gray
        contentView.addSubview(authorLabel)
        
        // --- Rating
        ratingLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        ratingLabel.textColor = .white
        ratingLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        ratingLabel.layer.cornerRadius = 6
        ratingLabel.clipsToBounds = true
        ratingLabel.textAlignment = .center
        contentView.addSubview(ratingLabel)
        
        // --- Bookmark button
        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        bookmarkButton.tintColor = .white
        bookmarkButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        bookmarkButton.layer.cornerRadius = 14
        bookmarkButton.clipsToBounds = true
        bookmarkButton.addTarget(self, action: #selector(toggleBookmark), for: .touchUpInside)
        contentView.addSubview(bookmarkButton)
        
        // --- Duration
        durationLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        durationLabel.textColor = .white
        durationLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        durationLabel.layer.cornerRadius = 6
        durationLabel.clipsToBounds = true
        durationLabel.textAlignment = .center
        contentView.addSubview(durationLabel)
        
        // --- Constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 180),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            // Rating в левом верхнем углу картинки
            ratingLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            ratingLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
            ratingLabel.widthAnchor.constraint(equalToConstant: 50),
            ratingLabel.heightAnchor.constraint(equalToConstant: 24),
            
            // Bookmark в правом верхнем углу картинки
            bookmarkButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            bookmarkButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 28),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 28),
            
            // Duration в правом нижнем углу картинки
            durationLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            durationLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -8),
            durationLabel.widthAnchor.constraint(equalToConstant: 50),
            durationLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with recipe: Recipe) {
        imageView.image = UIImage(named: recipe.image) ?? UIImage(systemName: "photo")
        titleLabel.text = recipe.title
        authorLabel.text = recipe.author
        ratingLabel.text = "⭐️ \(recipe.rating)"
        durationLabel.text = recipe.duration
    }
    
    // MARK: - Actions
    @objc private func toggleBookmark() {
        isBookmarked.toggle()
        let imageName = isBookmarked ? "bookmark.fill" : "bookmark"
        bookmarkButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}


class RecipesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    
    let recipes: [Recipe] = [
        Recipe(image: "food1", title: "How to make sharwama at home", author: "By Zeelicious Foods", rating: "5.0", duration: "15:10"),
        Recipe(image: "food2", title: "How to make sharwama at home", author: "By Zeelicious Foods", rating: "5.0", duration: "15:10"),
        Recipe(image: "food3", title: "How to make sharwama at home", author: "By Zeelicious Foods", rating: "5.0", duration: "15:10")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Saved recipes"
        view.backgroundColor = .systemBackground
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.identifier, for: indexPath) as! RecipeCell
        cell.configure(with: recipes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 280)
    }
}



//
//  ProfileVC.swift
//  BestRecipes
//
//  Created by Rustam Basanov on 24.08.2025.
//

import UIKit

class ProfileVC: UIViewController {
    
    //MARK: - UI
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "My profile"
        label.textColor = .label
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private var headerView: ProfileHeaderView!
    
    private let recipesLabel: UILabel = {
        let label = UILabel()
        label.text = "My recipes"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private var favoriteRecipes: [RecipeDetail] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
        collectionView.reloadData()
    }

    private func loadFavorites() {
        favoriteRecipes = StorageManager.shared.favoriteRecipes
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView = ProfileHeaderView(parentVC: self)
        headerView.delegate = self
        
        setupViews()
        setConstraints()
        setDelegates()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(headerView)
        view.addSubview(recipesLabel)
        view.addSubview(collectionView)
    }
    
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: "TrendingCell")
    }
    
    //MARK: - Constraints
    private func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        recipesLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            headerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            headerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 140),
            
            recipesLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            recipesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            collectionView.topAnchor.constraint(equalTo: recipesLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
}

// MARK: - Delegate
extension ProfileVC: ProfileHeaderViewDelegate {
    func didSelectImage(_ image: UIImage) {
        print("Выбран аватар: \(image)")
    }
}

// MARK: - Collection
extension ProfileVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteRecipes.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCell", for: indexPath) as! TrendingCell
        let recipe = favoriteRecipes[indexPath.item]
        cell.configure(with: recipe) 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 258)
    }
}

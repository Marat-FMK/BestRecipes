//
//  AllTrendingVC.swift
//  BestRecipes
//
//  Created by Евгений Васильев on 22.08.2025.
//

import UIKit

class AllTrendingViewController: UIViewController {
        
    //MARK: - Create UI
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Trending Now"
        label.textColor = .label
        label.font = UIFont(name: Constants.Fonts.poppinsSemiBold, size: 24)
        return label
    }()
    
    
    let backButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.Icons.arrowLeft), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    //MARK: - Action func
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        SetDelegatas()
        loadTrendingData()
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
    }
    
    private func loadTrendingData() {
            print("🔄 Loading trending data...")
            StorageManager.shared.setTrendingRecipes { [weak self] in
                DispatchQueue.main.async {
                    print("✅ Data loaded: \(StorageManager.shared.trendingRecipesAll.count) items")
                    self?.collectionView.reloadData()
                }
            }
        }

    // MARK: Set Delegatas
    
    func SetDelegatas() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: "TrendingCell")
    }
    
    //MARK: - setConstraints

    private func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 35),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
        ])
        
        
    }
}

// MARK: Extension ViewDelegate

extension AllTrendingViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Количество элементов: \(StorageManager.shared.trendingRecipesAll.count)")
        return StorageManager.shared.trendingRecipesAll.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCell", for: indexPath) as! TrendingCell
        let recepie = StorageManager.shared.trendingRecipesAll[indexPath.item]
        cell.configure(with: recepie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = RecipeDetailViewController()
        StorageManager.shared.saveRecentRecepie(recipe: StorageManager.shared.trendingRecipesAll[indexPath.item])
        vc.recipe = StorageManager.shared.trendingRecipesAll[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 258)
    }

}


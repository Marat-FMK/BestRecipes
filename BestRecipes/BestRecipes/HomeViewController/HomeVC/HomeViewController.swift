//
//  ViewController.swift
//  BestRecipes
//
//  Created by Marat Fakhrizhanov on 11.08.2025.
//
//
//  ViewController.swift
//  BestRecipes
//
//  Created by Marat Fakhrizhanov on 11.08.2025.
//

import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    
    var categoriesArray : [String] = ["main course","side dish","dessert", "appetizer", "salad","bread","breakfast","soup","beverage","sauce","marinade","fingerfood","snack","drink"]
    
//    var networkManager = NetworkManager()
    var storageManager = StorageManager()
    
    var trendingRecipes: [RecipeDetail] = []

    
    //MARK: - Create UI
    
    let scrollView : UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = true
        return view
    }()
    
    let topLabel : UILabel = {
        let label = UILabel()
        label.text = "Get amazing recipes\nfor cooking"
        label.font = UIFont(name: "Poppins", size: 24)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let searchTextField : UITextField = {
        let field = UITextField()
        field.placeholder = "Search recipes"
        field.backgroundColor = .systemGray6
        field.layer.cornerRadius = 12
        field.leftViewMode = .always
        let magnifyingGlass = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        magnifyingGlass.tintColor = .black
        magnifyingGlass.contentMode = .scaleAspectFit
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        magnifyingGlass.frame = CGRect(x: 10, y: 0, width: 20, height: 20)
        container.addSubview(magnifyingGlass)
        field.leftView = container
        return field
    }()
    
    let trendingLabel : UILabel = {
        let label = UILabel()
        label.text = "Trending now 🔥"
        label.font = UIFont(name: "Poppins", size: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let trendingSeeAll : SeeAllView = {
        let view = SeeAllView()
        view.seeAllButton.addTarget(self, action: #selector(trendingSeeAllButtontapped), for: .touchUpInside)
        return view
    }()
    
    let trendingCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    let popularLabel : UILabel = {
        let label = UILabel()
        label.text = "Popular category"
        label.font = UIFont(name: "Poppins", size: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let popularCategoryCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    lazy var categoryButtonsStackView : UIStackView = {
        let view = UIStackView()
        for category in storageManager.categories {
            let button = UIButton()
            button.setTitle(category, for: .normal)
            button.clipsToBounds = true
            button.imageView?.contentMode = .scaleAspectFill
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            button.setTitleColor(UIColor.primary20, for: .normal)
            button.setTitleColor(.white0, for: .selected)
            button.setBackgroundImage(nil, for: .normal)
            button.setBackgroundImage(UIImage(named: "buttonBackgroundImage"), for: .selected)
            button.layer.cornerRadius = 12
            button.titleLabel?.font = UIFont(name: "Poppins", size: 12)
            button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
            view.addArrangedSubview(button)
        }
        
        let savedCategory = UserDefaults.standard.string(forKey: Constants.UDConstants.currentCategory)
            if let savedCategory = savedCategory {
                if let buttonToSelect = view.arrangedSubviews.first(where: {
                    ($0 as? UIButton)?.titleLabel?.text == savedCategory
                }) as? UIButton {
                    buttonToSelect.isSelected = true
                }
            } else if let firstButton = view.arrangedSubviews.first as? UIButton {
                firstButton.isSelected = true
            }
        view.axis = .horizontal
        view.spacing = 20
        view.distribution = .fillProportionally
        return view
    }()
    
    let categoryScrollView : UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.alwaysBounceHorizontal = true
        return view
    }()
    
    let recentRecepieLabel : UILabel = {
        let label = UILabel()
        label.text = "Recent recepie"
        label.font = UIFont(name: "Poppins", size: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let recentSeeAll : SeeAllView = {
        let view = SeeAllView()
        view.seeAllButton.addTarget(self, action: #selector(recentSeeAllButtonTapped), for: .touchUpInside)
        return view
    }()
    
    let recentRecepieCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.isScrollEnabled = true
        return view
    }()
    
    let popularCreatorsLabel : UILabel = {
        let label = UILabel()
        label.text = "Popular creators"
        label.font = UIFont(name: "Poppins", size: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let popularCreatorSeeAll : SeeAllView = {
        let view = SeeAllView()
        view.seeAllButton.addTarget(self, action: #selector(popularCreatorSeeAllButtonTapped), for: .touchUpInside)
        return view
    }()
    
    let popularCreatorCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.isScrollEnabled = true
        return view
    }()
    
    //MARK: - Action Func
    
    @objc private func categoryButtonTapped(_ sender: UIButton) {
        sender.buttonTappedAnimate()
        categoryButtonsStackView.arrangedSubviews.forEach { view in
            if let button = view as? UIButton {
                button.isSelected = false
            }
            sender.isSelected = true
        }
        // MArat --->>>
        UserDefaults.standard.set(sender.titleLabel?.text, forKey: Constants.UDConstants.currentCategory) // MARAT
        storageManager.categoryRecipesAll = []
        storageManager.setCategotyRecipes {
            DispatchQueue.main.async {
                self.popularCategoryCollectionView.reloadData()
            }
        }
    }
    
    @objc private func trendingSeeAllButtontapped(sender : UIButton) {
        sender.buttonTappedAnimate()
        //ПОСМОТРЕТЬ ВСЕ ТРЕНДЫ
    }
    
    @objc private func recentSeeAllButtonTapped(sender : UIButton) {
        sender.buttonTappedAnimate()
        //ПОСМОТРЕТЬ ВСЕ НЕДАВНИЕ РЕЦЕПТЫ
    }
    
    @objc private func popularCreatorSeeAllButtonTapped(sender : UIButton) {
        sender.buttonTappedAnimate()
        //ПОСМОТРЕТЬ ВСЕ НЕДАВНИЕ РЕЦЕПТЫ
    }
    
    func trendsDownload() {
        let loader = UIActivityIndicatorView(style: .large)
        loader.startAnimating()
        trendingCollectionView.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        loader.leadingAnchor.constraint(equalTo: trendingCollectionView.leadingAnchor, constant: 25),
        loader.topAnchor.constraint(equalTo: trendingCollectionView.topAnchor, constant: 10),
        ])
        storageManager.setTrendingRecipes {
            DispatchQueue.main.async {
                loader.removeFromSuperview()
                self.trendingCollectionView.reloadData()
            }
        }
    }
    
    func categoryDownload() {
        let loader = UIActivityIndicatorView(style: .large)
        loader.startAnimating()
        popularCreatorCollectionView.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        loader.leadingAnchor.constraint(equalTo: trendingCollectionView.leadingAnchor, constant: 25),
        loader.topAnchor.constraint(equalTo: trendingCollectionView.topAnchor, constant: 10),
        ])
            storageManager.setCategotyRecipes {
                DispatchQueue.main.async {
                    loader.removeFromSuperview()
                    self.popularCategoryCollectionView.reloadData()
                }
            }
        }
        
//        func categoriesDownload() {
//            storageManager.setCategotyRecipes()
//            let loader = UIActivityIndicatorView(style: .large)
//            loader.startAnimating()
//            popularCategoryCollectionView.addSubview(loader)
//            loader.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                loader.leadingAnchor.constraint(equalTo: popularCategoryCollectionView.leadingAnchor, constant: 25),
//                loader.topAnchor.constraint(equalTo: popularCategoryCollectionView.topAnchor, constant: 10),
//               ])
//            popularCategoryCollectionView.addSubview(loader)
//            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
//                self.categoryRecepies = self.storageManager.categoryRecipes
//                self.popularCategoryCollectionView.reloadData()
//                loader.removeFromSuperview()
//            }
//        }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setDelegates()
        setupSearchField()
        trendsDownload()
        categoryDownload()
        recentRecepieCollectionView.reloadData()
    }
    
    private func setupViews() {
        view.backgroundColor = .white0
        view.addSubview(scrollView)
        view.addSubview(categoryScrollView)
        scrollView.addSubview(topLabel)
        scrollView.addSubview(searchTextField)
        scrollView.addSubview(trendingLabel)
        scrollView.addSubview(trendingSeeAll)
        scrollView.addSubview(trendingCollectionView)
        scrollView.addSubview(popularLabel)
        scrollView.addSubview(popularCategoryCollectionView)
        scrollView.addSubview(categoryScrollView)
        categoryScrollView.addSubview(categoryButtonsStackView)
        scrollView.addSubview(recentRecepieLabel)
        scrollView.addSubview(recentSeeAll)
        scrollView.addSubview(recentRecepieCollectionView)
        scrollView.addSubview(popularCreatorsLabel)
        scrollView.addSubview(popularCreatorSeeAll)
        scrollView.addSubview(popularCreatorCollectionView)
    }
    
    //MARK: - Set Delegates
    
    func setDelegates() {
        scrollView.delegate = self
        searchTextField.delegate = self
        trendingCollectionView.delegate = self
        trendingCollectionView.dataSource = self
        trendingCollectionView.register(TrendingCell.self, forCellWithReuseIdentifier: "TrendingCell")
        popularCategoryCollectionView.delegate = self
        popularCategoryCollectionView.dataSource = self
        popularCategoryCollectionView.register(PopularRecepieCell.self, forCellWithReuseIdentifier: "PopularCategoryCell")
        recentRecepieCollectionView.delegate = self
        recentRecepieCollectionView.dataSource = self
        recentRecepieCollectionView.register(RecentRecepieCell.self, forCellWithReuseIdentifier: "RecentPecepieCell")
        popularCreatorCollectionView.delegate = self
        popularCreatorCollectionView.dataSource = self
        popularCreatorCollectionView.register(CreatorCell.self, forCellWithReuseIdentifier: "CreatorCell")
        searchTextField.delegate = self

    }
    
    //MARK: - setConstraints
    
    private func setConstraints() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 28),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            searchTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        trendingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trendingLabel.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 15),
            trendingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        trendingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trendingCollectionView.topAnchor.constraint(equalTo: trendingLabel.bottomAnchor, constant: 16),
            trendingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            trendingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trendingCollectionView.heightAnchor.constraint(equalToConstant: 254)
        ])
        
        trendingSeeAll.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trendingSeeAll.centerYAnchor.constraint(equalTo: trendingLabel.centerYAnchor),
            trendingSeeAll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        popularLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popularLabel.topAnchor.constraint(equalTo: trendingCollectionView.bottomAnchor, constant: 24),
            popularLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        popularCategoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popularCategoryCollectionView.topAnchor.constraint(equalTo: popularLabel.bottomAnchor, constant: 74),
            popularCategoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            popularCategoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popularCategoryCollectionView.heightAnchor.constraint(equalToConstant: 231),
        ])
        
        categoryScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryScrollView.topAnchor.constraint(equalTo: popularLabel.bottomAnchor, constant: 20),
            categoryScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoryScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryScrollView.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        categoryButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryButtonsStackView.topAnchor.constraint(equalTo: categoryScrollView.contentLayoutGuide.bottomAnchor),
            categoryButtonsStackView.leadingAnchor.constraint(equalTo: categoryScrollView.contentLayoutGuide.leadingAnchor),
            categoryButtonsStackView.trailingAnchor.constraint(equalTo: categoryScrollView.contentLayoutGuide.trailingAnchor, constant: -25),
            categoryButtonsStackView.topAnchor.constraint(equalTo: categoryScrollView.contentLayoutGuide.topAnchor),
            categoryButtonsStackView.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        recentRecepieLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recentRecepieLabel.topAnchor.constraint(equalTo: popularCategoryCollectionView.bottomAnchor, constant: 20),
            recentRecepieLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        recentSeeAll.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recentSeeAll.centerYAnchor.constraint(equalTo: recentRecepieLabel.centerYAnchor),
            recentSeeAll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        recentRecepieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recentRecepieCollectionView.topAnchor.constraint(equalTo: recentSeeAll.bottomAnchor, constant: 16),
            recentRecepieCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            recentRecepieCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recentRecepieCollectionView.heightAnchor.constraint(equalToConstant: 190)
        ])
        
        popularCreatorsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popularCreatorsLabel.topAnchor.constraint(equalTo: recentRecepieCollectionView.bottomAnchor, constant: 25),
            popularCreatorsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        popularCreatorSeeAll.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popularCreatorSeeAll.centerYAnchor.constraint(equalTo: popularCreatorsLabel.centerYAnchor),
            popularCreatorSeeAll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        popularCreatorCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popularCreatorCollectionView.topAnchor.constraint(equalTo: popularCreatorsLabel.bottomAnchor, constant: 16),
            popularCreatorCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            popularCreatorCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popularCreatorCollectionView.heightAnchor.constraint(equalToConstant: 136),
            popularCreatorCollectionView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -100)
        ])
    }
}

//MARK: -  Extension UICollectionView

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
           case popularCategoryCollectionView:
               return storageManager.categoryRecipes.count
           case trendingCollectionView:
               return storageManager.trendingRecipes.count
           case recentRecepieCollectionView:
               return storageManager.recentRecipes.count
           case popularCreatorCollectionView:
               return storageManager.cuisineNames.count
           default:
               return 0
           }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case _ where collectionView == trendingCollectionView:
            let width = collectionView.frame.width - 95
            let height: CGFloat = collectionView.frame.height
            return CGSize(width: width, height: height)
        case _ where collectionView == popularCategoryCollectionView:
            let width = collectionView.frame.width - 224
            let height: CGFloat = collectionView.frame.height
            return CGSize(width: width, height: height)
        case _ where collectionView == recentRecepieCollectionView:
            let width = collectionView.frame.width - 251
            let height: CGFloat = collectionView.frame.height
            return CGSize(width: width, height: height)
        case _ where collectionView == popularCreatorCollectionView:
            let width = collectionView.frame.width - 300
            let height: CGFloat = collectionView.frame.height
            return CGSize(width: width, height: height)
        default:
            fatalError("Unknown collection view")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case _ where collectionView == trendingCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCell", for: indexPath) as! TrendingCell
            let recepie = storageManager.trendingRecipes[indexPath.item]
            cell.configure(with: recepie)
            return cell
            
        case _ where collectionView == popularCategoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCategoryCell", for: indexPath) as! PopularRecepieCell
                    let recipe = storageManager.categoryRecipes[indexPath.item]
                    cell.configure(with: recipe)
                    return cell
            
        case _ where collectionView == recentRecepieCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentPecepieCell", for: indexPath) as! RecentRecepieCell
            let recepie = storageManager.recentRecipes[indexPath.item]
            cell.configure(with: recepie)
            return cell
        case _ where collectionView == popularCreatorCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreatorCell", for: indexPath) as! CreatorCell
            cell.creatorLabel.text = storageManager.cuisineNames[indexPath.item]
            cell.backgroundImageView.image = UIImage(named: Constants.Cuisines[indexPath.item])
            return cell
        default:
            fatalError("Unknown collection view")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == trendingCollectionView {
            let vc = RecipeDetailViewController()
            storageManager.saveRecentRecepie(recipe: storageManager.trendingRecipes[indexPath.item])
            vc.recipe = storageManager.trendingRecipes[indexPath.item]
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = RecipeDetailViewController()
            storageManager.saveRecentRecepie(recipe: storageManager.categoryRecipes[indexPath.item])
            vc.recipe = storageManager.categoryRecipes[indexPath.item]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


//MARK: setup SearchField
extension HomeViewController {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        openSearch()
        return false
    }
    
    private func setupSearchField() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(openSearch))
        searchTextField.addGestureRecognizer(tap)
    }
    
    @objc private func openSearch() {
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            searchVC.activateSearch()
        }
    }
}


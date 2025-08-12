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
    
    
    
    
    //MARK: - Create UI
    
    let scrollView : UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = false
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
    
    let seeAllButton : UIButton = {
        let button = UIButton()
        button.setTitle("See all", for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 14)
        button.setTitleColor(UIColor.primary50, for: .normal)
        return button
    }()
    
    let arrowRightIcon : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Constants.Images.arrowRightImage)
        return view
    }()
    
    let trendingCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 150
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
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setDelegates()
    }
    
    private func setupViews() {
        view.backgroundColor = .white0
        view.addSubview(scrollView)
        scrollView.addSubview(topLabel)
        scrollView.addSubview(searchTextField)
        scrollView.addSubview(trendingLabel)
        scrollView.addSubview(seeAllButton)
        scrollView.addSubview(arrowRightIcon)
        scrollView.addSubview(trendingCollectionView)
        scrollView.addSubview(popularLabel)
    }
    
    //MARK: - Set Delegates
    
    func setDelegates() {
        scrollView.delegate = self
        searchTextField.delegate = self
        trendingCollectionView.delegate = self
        trendingCollectionView.dataSource = self
        trendingCollectionView.register(TrendingCell.self, forCellWithReuseIdentifier: "TrendingCell")
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
        
        arrowRightIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrowRightIcon.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 15),
            arrowRightIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            arrowRightIcon.widthAnchor.constraint(equalToConstant: 20),
            arrowRightIcon.heightAnchor.constraint(equalToConstant: 20),
            arrowRightIcon.centerXAnchor.constraint(equalTo: trendingLabel.centerXAnchor)
        ])
        
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            seeAllButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 15),
            seeAllButton.trailingAnchor.constraint(equalTo: arrowRightIcon.leadingAnchor, constant: -3),
            seeAllButton.centerYAnchor.constraint(equalTo: arrowRightIcon.centerYAnchor)
        ])
        
        trendingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trendingCollectionView.topAnchor.constraint(equalTo: trendingLabel.bottomAnchor, constant: 16),
            trendingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            trendingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trendingCollectionView.heightAnchor.constraint(equalToConstant: 254)
        ])
        
        popularLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popularLabel.topAnchor.constraint(equalTo: trendingCollectionView.bottomAnchor, constant: 24),
            popularLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 95
        let height: CGFloat = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCell", for: indexPath) as?
                TrendingCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}


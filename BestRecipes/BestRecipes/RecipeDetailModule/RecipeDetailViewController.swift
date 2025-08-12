//
//  ViewController.swift
//  BestRecipes
//
//  Created by Marat Fakhrizhanov on 11.08.2025.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    //MARK: - UI Components
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    //MARK: Navigation Bar Items
    
    private let backButton: UIButton = {
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(named: Constants.Icons.arrowLeft), for: .normal)
        return backButton
    }()
    
    private let navigationBarTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: Constants.Fonts.poppinsBold, size: 24)
        label.text = "Recipe Detail"
        return label
    }()
    
    //MARK: Headers
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
    
    private let instuctionsHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: Constants.Fonts.poppinsSemiBold, size: 20)
        label.text = "Instructions"
        return label
    }()
    
    private let ingredientsHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: Constants.Fonts.poppinsSemiBold, size: 20)
        label.text = "Ingredients"
        return label
    }()
    
    private let countOfItems: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: Constants.Fonts.poppinsRegular, size: 16)
        label.textColor = Constants.Colors.Neutral.neutral50
        label.text = "items"
        return label
    }()
    
    //MARK: Dish Image
    private let dishImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    //MARK: Reviews Section Items
    private let reviewsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
//        stack.distribution = .fill
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
    
    //MARK: Instruction Section
    
    private let instructionsView: UITextView = {
        let textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSelectable = false
        textField.isEditable = false
        textField.textContainerInset = .zero
        textField.textContainer.lineFragmentPadding = 0
        textField.text = "Some instructions"
        return textField
    }()
    
    //MARK: Ingredients Section
    private let igredientsTable: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RecipeDetailTableViewCell.self, forCellReuseIdentifier: RecipeDetailTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.igredientsTable.delegate = self
        self.igredientsTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool)  {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupUI() {
        view.backgroundColor = Constants.Colors.Neutral.white0
        
//        view.addSubview(scrollView)
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19)
//        ])
        //MARK: NavigationBar UI
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.titleView = navigationBarTitle
        
        //MARK: TopHeader UI
        view.addSubview(topHeader)
        NSLayoutConstraint.activate([
            topHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 19),
            topHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19)
        ])
        
        //MARK: DishImage UI
        view.addSubview(dishImage)
        NSLayoutConstraint.activate([
            dishImage.topAnchor.constraint(equalTo: topHeader.bottomAnchor, constant: 13),
            dishImage.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 19),
            dishImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
            dishImage.heightAnchor.constraint(equalToConstant: 200)
        ])
//        dishImage.image = UIImage(named: )
        dishImage.backgroundColor = .red
        
        //MARK: Rating Section UI
        view.addSubview(reviewsStack)
        NSLayoutConstraint.activate([
            reviewsStack.topAnchor.constraint(equalTo: dishImage.bottomAnchor, constant: 13),
            reviewsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 19),
            reviewsStack.heightAnchor.constraint(equalToConstant: 20)
        ])
        reviewsStack.addArrangedSubview(reviewsImage)
        reviewsStack.addArrangedSubview(recipeRating)
        reviewsStack.addArrangedSubview(countOfReviews)
        
        //MARK: Instructions Section UI
        view.addSubview(instructionsView)
        NSLayoutConstraint.activate([
            instructionsView.topAnchor.constraint(equalTo: reviewsStack.bottomAnchor, constant: 13),
            instructionsView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 19),
            instructionsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
            instructionsView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        //MARK: Ingredients Section UI
        view.addSubview(ingredientsHeader)
        NSLayoutConstraint.activate([
            ingredientsHeader.topAnchor.constraint(equalTo: instructionsView.bottomAnchor, constant: 37),
            ingredientsHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 19),
            ingredientsHeader.heightAnchor.constraint(equalToConstant: 28)
        ])
        view.addSubview(countOfItems)
        NSLayoutConstraint.activate([
            countOfItems.topAnchor.constraint(equalTo: instructionsView.bottomAnchor, constant: 37),
            countOfItems.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -19),
            countOfItems.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
}

extension RecipeDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeDetailTableViewCell.identifier, for: indexPath) as! RecipeDetailTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
}

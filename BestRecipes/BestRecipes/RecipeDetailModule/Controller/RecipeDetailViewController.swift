//
//  ViewController.swift
//  BestRecipes
//
//  Created by Marat Fakhrizhanov on 11.08.2025.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: RecipeDetail?
    
    //MARK: - UI Components
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
    
    //MARK: Main
    private let recipeDetailTable: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RecipeDetailAboutCell.self, forCellReuseIdentifier: RecipeDetailAboutCell.identifier)
        tableView.register(RecipeDetailInstructionsCell.self, forCellReuseIdentifier: RecipeDetailInstructionsCell.identifier)
        tableView.register(RecipeDetailTableViewCell.self, forCellReuseIdentifier: RecipeDetailTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 1000
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setupUI()
        self.recipeDetailTable.delegate = self
        self.recipeDetailTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool)  {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupUI() {
        view.backgroundColor = Constants.Colors.Neutral.white0
        
        //MARK: NavigationBar UI
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.titleView = navigationBarTitle
        backButton.addTarget(self, action: #selector(backButtonTapped(sender:)), for: .touchUpInside)
        //MARK: UI
            view.addSubview(recipeDetailTable)
        NSLayoutConstraint.activate([
            recipeDetailTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            recipeDetailTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
            recipeDetailTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            recipeDetailTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
//MARK: - BackButton Func
    @objc func backButtonTapped(sender: UIButton) {
        sender.buttonTappedAnimate()
        print("pressed")
        navigationController?.popViewController(animated: true)
    }
}

extension RecipeDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeDetailAboutCell.identifier, for: indexPath) as! RecipeDetailAboutCell
            if let recipe = self.recipe {
                cell.configure(with: recipe)
            }
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeDetailInstructionsCell.identifier, for: indexPath) as! RecipeDetailInstructionsCell
            if let recipe = self.recipe {
                cell.configure(with: recipe)
            }
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeDetailTableViewCell.identifier, for: indexPath) as! RecipeDetailTableViewCell
            cell.selectionStyle = .none
            if let recipe = self.recipe {
                cell.configure(with: recipe, counter: indexPath.row - 2)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let counter = recipe?.extendedIngredients.count else { return 2 }
        return 2 + counter
    }
}

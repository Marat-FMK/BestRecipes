//
//  SearchViewController.swift
//  BestRecipes
//
//  Created by Сергей on 12.08.2025.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var recipes: [Recipe] = [
        Recipe(title: "How to make yam & vegetable sauce at home", ingredients: "9 Ingredients", time: "25 min", imageName: "shawarma_image", rating: "5.0"),
        Recipe(title: "Spaghetti Bolognese", ingredients: "8 Ingredients", time: "30 min", imageName: "shawarma_image", rating: "4.8"),
        Recipe(title: "Chicken Curry", ingredients: "12 Ingredients", time: "45 min", imageName: "shawarma_image", rating: "4.9"),
        Recipe(title: "Pancakes", ingredients: "5 Ingredients", time: "15 min", imageName: "shawarma_image", rating: "4.7"),
        Recipe(title: "Fruit Salad", ingredients: "6 Ingredients", time: "10 min", imageName: "shawarma_image", rating: "4.6"),
        Recipe(title: "Test", ingredients: "9 Ingredients", time: "25 min", imageName: "shawarma_image", rating: "5.0"),
        Recipe(title: "Low", ingredients: "9 Ingredients", time: "25 min", imageName: "shawarma_image", rating: "5.0"),
        Recipe(title: "Lower", ingredients: "9 Ingredients", time: "25 min", imageName: "shawarma_image", rating: "5.0"),
    ]
    private var filteredRecipes: [Recipe] = []
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    // MARK: - Setup
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        let searchBar = searchController.searchBar
        searchBar.placeholder = "How to make"
        searchBar.showsCancelButton = false
        
        let textField = searchBar.searchTextField
        textField.textColor = .black
        textField.font = UIFont(name: "Poppins-Regular", size: 14)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "Primary 50")?.cgColor
        textField.layer.masksToBounds = true
        
        if let leftIconView = textField.leftView as? UIImageView {
            leftIconView.image = UIImage(systemName: "magnifyingglass")
            leftIconView.tintColor = .black
        }
        
        if let clearButton = textField.value(forKey: "_clearButton") as? UIButton {
            clearButton.setImage(UIImage(systemName: "xmark"), for: .normal)
            clearButton.tintColor = .black
        }
        
        let toolbar = UIToolbar()
           toolbar.sizeToFit()
           let doneButton = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(dismissKeyboard))
           let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
           toolbar.items = [flexSpace, doneButton]
           
           searchBar.searchTextField.inputAccessoryView = toolbar
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.hidesBackButton = true
    }
    
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.identifier)
    }
    
    private func setupUI() {
        filteredRecipes = recipes
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc private func closeButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        definesPresentationContext = true // <- важно для активации поиска
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = "Search recipes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeButtonTapped)
        )
        
        setupTableView()
        setupSearchController()
        setupUI()
        setupKeyboardDismiss()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activateSearch()
    }
    
    func activateSearch() {
        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.identifier, for: indexPath) as? RecipeCell else {
            return UITableViewCell()
        }
        cell.configure(with: filteredRecipes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text?.lowercased() ?? ""
        
        if searchText.isEmpty {
            filteredRecipes = recipes
        } else {
            filteredRecipes = recipes.filter { $0.title.lowercased().contains(searchText) }
        }
        
        tableView.reloadData()
    }
}

//MARK: - keyBoard
extension SearchViewController {
    func setupKeyboardDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        searchController.searchBar.resignFirstResponder()
    }
}

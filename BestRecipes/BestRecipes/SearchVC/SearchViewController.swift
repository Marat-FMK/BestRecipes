//
//  SearchViewController.swift
//  BestRecipes
//
//  Created by Сергей on 12.08.2025.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let storageManager = StorageManager.shared
//    private var recipes: [RecipeDetail] = []
    
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
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        let searchBar = searchController.searchBar
        searchBar.placeholder = "How to make"
        searchBar.showsCancelButton = false
        searchBar.delegate = self
        
        let textField = searchBar.searchTextField
        textField.textColor = .black
        textField.font = UIFont(name: Constants.Fonts.poppinsRegular, size: 14)
        textField.backgroundColor = Constants.Colors.Neutral.white0
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Constants.Colors.Primary.primary50?.cgColor
        textField.layer.masksToBounds = true
        
        if let leftIconView = textField.leftView as? UIImageView {
            leftIconView.image = UIImage(systemName: "magnifyingglass")
            leftIconView.tintColor = Constants.Colors.Neutral.neutral100
        }
        
        if let clearButton = textField.value(forKey: "_clearButton") as? UIButton {
            clearButton.setImage(UIImage(systemName: "xmark"), for: .normal)
            clearButton.tintColor = Constants.Colors.Neutral.neutral100
        }
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.hidesBackButton = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RecipeDiscover.self, forCellReuseIdentifier: RecipeDiscover.identifier)
    }
    
    private func setupConstraints() {
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
        definesPresentationContext = true
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = "Search recipes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeButtonTapped)
        )
        
        setupTableView()
        setupSearchController()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool)  {
        super.viewWillAppear(animated)
        self.tabBarController?.setTabBarHidden(true, animated: false)
        (tabBarController as? TabBarViewController)?.customTabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activateSearch()
    }
    
    private func activateSearch() {
        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storageManager.searchedRecipes.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeDiscover.identifier, for: indexPath) as? RecipeDiscover else {
            return UITableViewCell()
        }
        cell.configure(with: storageManager.searchedRecipes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = storageManager.searchedRecipes[indexPath.row]
        
        StorageManager.shared.saveRecentRecepie(recipe: recipe)
        let detailVC = RecipeDetailViewController()
        detailVC.recipe = recipe
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }

        storageManager.searchText = searchText
        storageManager.setSearchRecipes {
            DispatchQueue.main.async {
//                self.recipes = self.storageManager.searchedRecipes
//                storageManager.searchedRecipes
                self.tableView.reloadData()
            }
        }
        searchBar.resignFirstResponder()
    }
}



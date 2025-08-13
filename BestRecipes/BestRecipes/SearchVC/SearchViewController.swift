//
//  SearchViewController.swift
//  BestRecipes
//
//  Created by Сергей on 12.08.2025.
//


import UIKit


// MARK: - Main Screen
class SearchViewController: UIViewController {
    
    private let searchContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.primary50.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let searchIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        iv.tintColor = .black
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let searchTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "How to make"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let clearButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.tintColor = .black
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    private var recipes: [Recipe] = [
        Recipe(title: "How to make yam & vegetable sauce at home", ingredients: "9 Ingredients", time: "25 min", imageName: "shawarma_image", rating: "5.0"),
        Recipe(title: "How to make yam & vegetable sauce at home", ingredients: "9 Ingredients", time: "25 min", imageName: "shawarma_image", rating: "5.0"),
        Recipe(title: "How to make yam & vegetable sauce at home", ingredients: "9 Ingredients", time: "25 min", imageName: "shawarma_image", rating: "5.0"),
        Recipe(title: "How to make yam & vegetable sauce at home", ingredients: "9 Ingredients", time: "25 min", imageName: "shawarma_image", rating: "5.0"),
        Recipe(title: "How to make yam & vegetable sauce at home", ingredients: "9 Ingredients", time: "25 min", imageName: "shawarma_image", rating: "5.0"),
        Recipe(title: "test", ingredients: "9 Ingredients", time: "25 min", imageName: "shawarma_image", rating: "5.0"),
        Recipe(title: "low", ingredients: "9 Ingredients", time: "25 min", imageName: "shawarma_image", rating: "5.0"),
        Recipe(title: "lower", ingredients: "9 Ingredients", time: "25 min", imageName: "shawarma_image", rating: "5.0"),
        
    ]
    
    private var filterRecipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupSearchBar()
        setupTableView()
    }
    
    private func setupSearchBar() {
        view.addSubview(searchContainer)
        searchContainer.addSubview(searchIcon)
        searchContainer.addSubview(searchTextField)
        searchContainer.addSubview(clearButton)
        
        NSLayoutConstraint.activate([
            searchContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            searchContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchContainer.heightAnchor.constraint(equalToConstant: 44),
            
            searchIcon.centerYAnchor.constraint(equalTo: searchContainer.centerYAnchor),
            searchIcon.leadingAnchor.constraint(equalTo: searchContainer.leadingAnchor, constant: 12),
            searchIcon.widthAnchor.constraint(equalToConstant: 20),
            searchIcon.heightAnchor.constraint(equalToConstant: 20),
            
            searchTextField.centerYAnchor.constraint(equalTo: searchContainer.centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 8),
            searchTextField.trailingAnchor.constraint(equalTo: clearButton.leadingAnchor, constant: -8),
            
            clearButton.centerYAnchor.constraint(equalTo: searchContainer.centerYAnchor),
            clearButton.trailingAnchor.constraint(equalTo: searchContainer.trailingAnchor, constant: -12),
            clearButton.widthAnchor.constraint(equalToConstant: 24),
            clearButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        clearButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.identifier)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchContainer.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func textFieldDidChange() {
        if let text = searchTextField.text {
            filterRecipes = recipes.filter { recipe in
                recipe.title.lowercased().contains(text.lowercased())
            }
        }
        tableView.reloadData()
    }
    
    @objc private func closeView() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
//MARK: UITableViewDataSource, UITableViewDelegate
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let text = searchTextField.text, !text.isEmpty {
            return filterRecipes.count
        } else {
            return recipes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.identifier, for: indexPath) as? RecipeCell else {
            return UITableViewCell()
        }
        
        if filterRecipes.count > 0 {
            cell.configure(with: filterRecipes[indexPath.row])
        } else {
            cell.configure(with: recipes[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedRecipe: Recipe
        if filterRecipes.count > 0 {
            selectedRecipe = filterRecipes[indexPath.row]
        } else {
            selectedRecipe = recipes[indexPath.row]
        }
        print(selectedRecipe)
        
//        let detailVC = RecipeDetailViewController()
//        detailVC.recipe = selectedRecipe
//        navigationController?.pushViewController(detailVC, animated: true)

    }
}

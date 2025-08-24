//
//  RecentRecipesViewController.swift
//  BestRecipes
//
//  Created by Marat Fakhrizhanov on 24.08.2025.
//



import UIKit

//class RecentRecipesViewController: UIViewController {
//    
//    private let storageManager = StorageManager.shared
//    private var recipes: [RecipeDetail] = []
//    
//    // MARK: - Back Button
//    let backButton: UIButton = {
//        let button = UIButton(type: .system)
//        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
//        let image = UIImage(systemName: "chevron.left", withConfiguration: config)
//        button.setImage(image, for: .normal)
//        button.tintColor = .black
//        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
//        return button
//    }()
//    
//    // MARK: - TableView
//    private let tableView: UITableView = {
//        let tv = UITableView()
//        tv.translatesAutoresizingMaskIntoConstraints = false
//        tv.separatorStyle = .none
//        tv.backgroundColor = .clear
//        return tv
//    }()
//    
//    // MARK: - Placeholder Label
//    private let placeholderLabel: UILabel = {
//        let label = UILabel()
//        label.text = "No recent recipes"
//        label.textColor = .gray
//        label.font = .systemFont(ofSize: 18, weight: .medium)
//        label.textAlignment = .center
//        label.isHidden = true // скрываем по умолчанию
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    // MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
//        title = "Recent Recipes"
//        
//        setupTableView()
//        setupPlaceholder()
//        setupConstraints()
//        loadRecentRecipes()
//        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
//    }
//    
//    // MARK: - Back Button Action
//
//    
//    @objc func backButtonTapped() {
//        navigationController?.popViewController(animated: true)
//    }
//    
//    // MARK: - Setup TableView
//    private func setupTableView() {
//        view.addSubview(tableView)
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(RecipeDiscover.self, forCellReuseIdentifier: RecipeDiscover.identifier)
//    }
//    
//    private func setupPlaceholder() {
//        view.addSubview(placeholderLabel)
//        NSLayoutConstraint.activate([
//            placeholderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            placeholderLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
//    
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//    
//    private func loadRecentRecipes() {
//        recipes = storageManager.recentRecipes
//        tableView.reloadData()
//        placeholderLabel.isHidden = !recipes.isEmpty // показываем заглушку если пусто
//    }
//}


class RecentRecipesViewController: UIViewController {
    private let storageManager = StorageManager.shared
    private var recipes: [RecipeDetail] = []
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        return tv
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "arrowLeft"), for: .normal)
//        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
//        button.setImage(UIImage(systemName: "chevron.left", withConfiguration: config), for: .normal)
        button.tintColor = .black
        return button
    }()

    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "No recent recipes"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Recent Recipes"

        setupTableView()
        setupPlaceholder()
        setupConstraints()
        loadRecentRecipes()

        // ✅ нормальный back item без customView
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
    }

    // ✅ Универсальный «назад»: если push — pop; если present — dismiss
    @objc private func backButtonTapped() {
        if let nav = navigationController, nav.viewControllers.first !== self {
            nav.popViewController(animated: true)
        } else if presentingViewController != nil {
            dismiss(animated: true)
        } else {
            // запасной вариант (если вдруг оказались корневым VC)
            navigationController?.popToRootViewController(animated: true)
        }
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RecipeDiscover.self, forCellReuseIdentifier: RecipeDiscover.identifier)
    }

    private func setupPlaceholder() {
        view.addSubview(placeholderLabel)
        NSLayoutConstraint.activate([
            placeholderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func loadRecentRecipes() {
        recipes = storageManager.recentRecipes
        tableView.reloadData()
        placeholderLabel.isHidden = !recipes.isEmpty
    }
}

// // // ЩОставляем -->>
// MARK: - UITableViewDataSource & UITableViewDelegate
extension RecentRecipesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RecipeDiscover.identifier,
            for: indexPath
        ) as? RecipeDiscover else {
            return UITableViewCell()
        }
        let recipe = recipes[indexPath.row]
        cell.configure(with: recipe)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        let detailVC = RecipeDetailViewController()
        detailVC.recipe = recipe
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

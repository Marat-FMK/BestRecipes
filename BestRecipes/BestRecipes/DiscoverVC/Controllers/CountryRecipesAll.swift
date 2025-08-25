//
//  CountryRecipesAll.swift
//  BestRecipes
//
//  Created by Marat Fakhrizhanov on 24.08.2025.
//

import UIKit

class CountryRecipesAllViewController: UIViewController {
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
        let button = UIButton()
        button.setImage(UIImage(named: Constants.Icons.arrowLeft), for: .normal)
        return button
    }()

    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "No recent recipes"
        label.textColor = .gray
        label.font = UIFont(name: Constants.Fonts.poppinsSemiBold, size: 18)
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "All Cuisines"

        setupTableView()
        setupPlaceholder()
        setupConstraints()
        loadRecentRecipes()

        // ✅ нормальный back item без customView
//        navigationItem.leftBarButtonItem = UIBarButtonItem(
//            image: UIImage(systemName: "chevron.left"),
//            style: .plain,
//            target: self,
//            action: #selector(backButtonTapped)
//        )
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
        recipes = storageManager.currentCuisineRecipes
        tableView.reloadData()
        placeholderLabel.isHidden = !recipes.isEmpty
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension CountryRecipesAllViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        StorageManager.shared.saveRecentRecepie(recipe: recipe)
        let detailVC = RecipeDetailViewController()
        
        detailVC.recipe = recipe
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

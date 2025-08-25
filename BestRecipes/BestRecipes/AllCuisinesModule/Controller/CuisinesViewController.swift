//
//  CuisineTableViewController.swift
//  BestRecipes
//
//  Created by Aliaksandr Zuyeu on 24.08.25.
//

import UIKit

class CuisinesViewController: UIViewController {
    
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
        label.text = "All Cuisines"
        return label
    }()
    
    private let cuisinesTable: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CuisineTableViewCell.self, forCellReuseIdentifier: CuisineTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.cuisinesTable.delegate = self
        self.cuisinesTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool)  {
        super.viewWillAppear(animated)
        self.tabBarController?.setTabBarHidden(true, animated: false)
        (tabBarController as? TabBarViewController)?.customTabBar.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = Constants.Colors.Neutral.white0
        
        //MARK: NavigationBar UI
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.titleView = navigationBarTitle
        backButton.addTarget(self, action: #selector(backButtonTapped(sender:)), for: .touchUpInside)
        //MARK: UI
        view.addSubview(cuisinesTable)
        NSLayoutConstraint.activate([
            cuisinesTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cuisinesTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
            cuisinesTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            cuisinesTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //MARK: - BackButton Func
    @objc func backButtonTapped(sender: UIButton) {
        sender.buttonTappedAnimate()
        navigationController?.popViewController(animated: true)
    }
}

extension CuisinesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CuisineTableViewCell.identifier, for: indexPath) as! CuisineTableViewCell
        cell.selectionStyle = .none
        cell.configureForCuisine(cuisineName: StorageManager.shared.cuisineNamesAll[indexPath.item], cuisineImage: UIImage(named: Constants.Cuisines[indexPath.item])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StorageManager.shared.cuisineNamesAll.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CuisineRecipesViewController()
        vc.setNavBarTitle(title: "\(StorageManager.shared.cuisineNamesAll[indexPath.item]) cuisine")
        navigationController?.pushViewController(vc, animated: true)
    }
}

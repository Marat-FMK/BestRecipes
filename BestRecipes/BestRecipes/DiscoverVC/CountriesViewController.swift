//
//  CountriesViewController.swift
//  BestRecipes
//
//  Created by Marat Fakhrizhanov on 24.08.2025.
//

import UIKit

class CountriesViewController: UIViewController {
    
    private let tableView = UITableView()
    var countries: [String] = StorageManager.shared.cuisineNamesAll
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "arrowLeft"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "All Cuisines"
        view.backgroundColor = .systemBackground
        
        setupTableView()
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc private func backButtonTapped() {
        if let nav = navigationController, nav.viewControllers.first !== self {
            nav.popViewController(animated: true)
        } else if presentingViewController != nil {
            dismiss(animated: true)
        } else {
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        // регистрация кастомной ячейки
        tableView.register(CountryCell.self, forCellReuseIdentifier: CountryCell.identifier)
    }
}

// MARK: - UITableView Delegate/DataSource
extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.identifier, for: indexPath) as? CountryCell else {
            return UITableViewCell()
        }
        let country = countries[indexPath.row]
        cell.configure(with: country)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CountryCell else { return }
        cell.animateSelection()
        
        let selectedCountry = countries[indexPath.row]
        var selectedCountryCuisineType = WorldCuisines.american
        
        switch selectedCountry {
        case "African": selectedCountryCuisineType = WorldCuisines.african
//        case "Asian": selectedCountryCuisineType = WorldCuisines.asian
        case "American": selectedCountryCuisineType = WorldCuisines.american
        case "British": selectedCountryCuisineType = WorldCuisines.british
//        case "Cajun": selectedCountryCuisineType = WorldCuisines.cajun
//        case "Caribbean": selectedCountryCuisineType = WorldCuisines.caribbean
        case "Chinese": selectedCountryCuisineType = WorldCuisines.chinese
//        case "EasternEuropean": selectedCountryCuisineType = WorldCuisines.easternEuropean
        case "European": selectedCountryCuisineType = WorldCuisines.european
        case "French": selectedCountryCuisineType = WorldCuisines.french
        case "German": selectedCountryCuisineType = WorldCuisines.german
        case "Greek": selectedCountryCuisineType = WorldCuisines.greek
        case "Indian": selectedCountryCuisineType = WorldCuisines.indian
        case "Irish": selectedCountryCuisineType = WorldCuisines.irish
        case "Italian": selectedCountryCuisineType = WorldCuisines.italian
        case "Japanese": selectedCountryCuisineType = WorldCuisines.japanese
//        case "Jewish": selectedCountryCuisineType = WorldCuisines.jewish
        case "Korean": selectedCountryCuisineType = WorldCuisines.korean
//        case "LatinAmerican": selectedCountryCuisineType = WorldCuisines.latinAmerican
//        case "Mediterranean": selectedCountryCuisineType = WorldCuisines.mediterranean
        case "Mexican": selectedCountryCuisineType = WorldCuisines.mexican
//        case "MiddleEastern": selectedCountryCuisineType = WorldCuisines.middleEastern
//        case "Nordic": selectedCountryCuisineType = WorldCuisines.nordic
//        case "Southern": selectedCountryCuisineType = WorldCuisines.southern
        case "Spanish": selectedCountryCuisineType = WorldCuisines.spanish
        case "Thai": selectedCountryCuisineType = WorldCuisines.thai
        case "Vietnamese": selectedCountryCuisineType = WorldCuisines.vietnamese
        default:
            selectedCountryCuisineType = WorldCuisines.thai
        }
        
        StorageManager.shared.choosedCuisine = selectedCountryCuisineType
        StorageManager.shared.setCurrentCuisineRecipes {
            DispatchQueue.main.async {
                let recipesVC = CountryRecipesAllViewController()
                self.navigationController?.pushViewController(recipesVC, animated: true)
            }
        }
    }
}

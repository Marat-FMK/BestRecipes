//
//  ViewController.swift
//  BestRecipes
//
//  Created by Marat Fakhrizhanov on 11.08.2025.
//

import UIKit

class HomeViewController: UIViewController {

    enum Constants {
        
    }
    
    //MARK: - Create UI
    
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
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white0
        view.addSubview(topLabel)
        view.addSubview(searchTextField)
    }
    
    //MARK: - setConstraints
    
    private func setConstraints() {
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 28),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            searchTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}


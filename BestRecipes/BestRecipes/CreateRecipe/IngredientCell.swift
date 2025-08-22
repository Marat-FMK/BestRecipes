//
//  IngredientCell.swift
//  BestRecipes
//
//  Created by Сергей on 22.08.2025.
//

import UIKit

class IngredientCell: UITableViewCell, UITextFieldDelegate {
    static let identifier = "IngredientCell"

    private let containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let nameField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Item name"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    let quantityField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Quantity"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    let actionButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .black
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    var actionHandler: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        nameField.delegate = self
        quantityField.delegate = self
        
        

        contentView.addSubview(containerView)
        containerView.addSubview(nameField)
        containerView.addSubview(quantityField)
        containerView.addSubview(actionButton)

        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            nameField.topAnchor.constraint(equalTo: containerView.topAnchor),
            nameField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            nameField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            nameField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4),

            quantityField.leadingAnchor.constraint(equalTo: nameField.trailingAnchor, constant: 12),
            quantityField.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: -12),
            quantityField.topAnchor.constraint(equalTo: containerView.topAnchor),
            quantityField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            actionButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 24),
            actionButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        setupCell()
    }

    @objc private func buttonTapped() {
        actionHandler?()
    }
    
    private func setupCell() {
        nameField.text = ""
        quantityField.text = ""
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

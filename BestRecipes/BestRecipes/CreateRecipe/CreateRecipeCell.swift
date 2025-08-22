//
//  CreateRecipeVC.swift
//  BestRecipes
//
//  Created by Сергей on 22.08.2025.
//

import UIKit


class CreateRecipeViewController: UIViewController, UINavigationControllerDelegate,
                                  UIImagePickerControllerDelegate {

    private var infoArray =  [
        InfoModel(title: "Serves", iconImage: "person.2.fill", value: "03"),
        InfoModel(title: "Cook time", iconImage: "timer.circle.fill", value: "20 min")
    ]
    var ingredients = 0

    private var ingredientsTableHeightConstraint: NSLayoutConstraint!
    private var infoTableHeightConstraint: NSLayoutConstraint!

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private let contentView: UIStackView = {
        let cv = UIStackView()
        cv.axis = .vertical
        cv.spacing = 16
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "photo")
        iv.backgroundColor = .gray
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        iv.tintColor = .black
        iv.isUserInteractionEnabled = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let addImageButton: UIButton = {
        var config = UIButton.Configuration.plain()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .small)
        config.image = UIImage(systemName: "pencil.line")?.withConfiguration(imageConfig)

        let bt = UIButton(configuration: config)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.clipsToBounds = true
        bt.layer.cornerRadius = 16
        bt.backgroundColor = .white
        bt.tintColor = .black

        return bt
    }()

    private var nameRecipeTextField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "Name recipe"
        tf.backgroundColor = .white
        tf.tintColor = .black
        tf.borderStyle = .roundedRect
        tf.clipsToBounds = true

        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    private let tableViewInfoRecipes: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.rowHeight = 76
        tv.isScrollEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    private let tableViewIngredients: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.rowHeight = 61
        tv.isScrollEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = false

        let headerLabel = UILabel()
        headerLabel.text = "Ingredients"
        headerLabel.font = UIFont(name: "Poppins-Bold", size: 20)
        headerLabel.frame = CGRect(x: 0, y: 0, width: tv.frame.width, height: 30)

        headerLabel.textAlignment = .left

        tv.tableHeaderView = headerLabel

        return tv
    }()

    private let createButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Create recipe", for: .normal)
        btn.backgroundColor = .primary50
        btn.tintColor = .white
        btn.layer.cornerRadius = 8
        btn.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 16)
    
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create recipe"
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false

        nameRecipeTextField.delegate = self

        tableViewInfoRecipes.register(InfoRowCell.self, forCellReuseIdentifier: InfoRowCell.identifier)
        tableViewInfoRecipes.dataSource = self
        tableViewInfoRecipes.delegate = self

        tableViewIngredients.register(IngredientCell.self, forCellReuseIdentifier: IngredientCell.identifier)
        tableViewIngredients.dataSource = self
        tableViewIngredients.delegate = self
        tableViewIngredients.allowsSelection = false

        addImageButton.addTarget(self, action: #selector(addImage), for: .touchUpInside)

        setupLayout()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateIngredientsTableHeight()
        tableViewInfoRecipes.layoutIfNeeded()
        infoTableHeightConstraint.constant = tableViewInfoRecipes.contentSize.height
    }

    private func setupLayout() {

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addArrangedSubview(imageView)
        imageView.addSubview(addImageButton)
        contentView.addArrangedSubview(nameRecipeTextField)
        contentView.addArrangedSubview(tableViewInfoRecipes)
        contentView.addArrangedSubview(tableViewIngredients)
        view.addSubview(createButton)
        
        infoTableHeightConstraint = tableViewInfoRecipes.heightAnchor.constraint(equalToConstant: 1)
        infoTableHeightConstraint.isActive = true

        ingredientsTableHeightConstraint = tableViewIngredients.heightAnchor.constraint(equalToConstant: 1)
        ingredientsTableHeightConstraint.isActive = true
        
        createButton.addTarget(self, action: #selector(createButtonDidTapped), for: .touchUpInside)


        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),

            imageView.heightAnchor.constraint(equalToConstant: 200),
            addImageButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            addImageButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            addImageButton.widthAnchor.constraint(equalToConstant: 32),
            addImageButton.heightAnchor.constraint(equalToConstant: 32),
            nameRecipeTextField.heightAnchor.constraint(equalToConstant: 45),

            createButton.heightAnchor.constraint(equalToConstant: 56),
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),

        ])
    }
}


extension CreateRecipeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension CreateRecipeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewInfoRecipes {
            return infoArray.count
        } else if tableView == tableViewIngredients {
            return ingredients + 1
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewInfoRecipes {
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoRowCell.identifier, for: indexPath) as! InfoRowCell
            let item = infoArray[indexPath.row]
            cell.configure(icon: item.iconImage, title: item.title, value: item.value)
            return cell
        } else if tableView == tableViewIngredients {
            let cell = IngredientCell()

            if indexPath.row < ingredients {
                cell.actionButton.setImage(UIImage(systemName: "minus.square"), for: .normal)
                
                cell.actionHandler = { [weak self, weak tableView, weak cell] in
                    guard let self = self,
                          let tableView = tableView,
                          let cell = cell,
                          let indexPath = tableView.indexPath(for: cell) else { return }

                    ingredients -= 1
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    self.updateIngredientsTableHeight()
                }

            } else {
                cell.nameField.isUserInteractionEnabled = false
                cell.quantityField.isUserInteractionEnabled = false
                cell.actionButton.setImage(UIImage(systemName: "plus.square"), for: .normal)

                cell.actionHandler = { [weak self, weak tableView] in
                    guard let self = self,
                          let tableView = tableView else { return }

                    let newIndex = ingredients
                    ingredients += 1
                    tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .automatic)
                    self.updateIngredientsTableHeight()
                }
            }

            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = infoArray[indexPath.row]

        let alert = UIAlertController(title: "Edit \(item.title)", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.keyboardType = .numberPad

            switch item.title {
            case "Serves":
                textField.text = "\(Int(item.value) ?? 1)"
            case "Cook time":
                let digits = item.value.prefix { $0.isNumber }
                textField.text = String(digits)
            default:
                return
            }
        }

        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            if let newValue = alert.textFields?.first?.text {
                switch item.title {
                case "Serves":
                    self?.infoArray[indexPath.row].value = String(format: "%02d", Int(newValue) ?? 0)
                case "Cook time":
                    self?.infoArray[indexPath.row].value = "\(newValue) min"
                default:
                    return
                }
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }

        alert.addAction(saveAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alert, animated: true)
    }

    private func updateIngredientsTableHeight() {
        tableViewIngredients.layoutIfNeeded()
        ingredientsTableHeightConstraint.constant = tableViewIngredients.contentSize.height
    }

    @objc private func addImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    @objc private func createButtonDidTapped() {
        if let title = nameRecipeTextField.text,
           title != "" {
            let servings = Int(infoArray[0].value) ?? 0
            let cookingMinutes = Int(infoArray[1].value.filter { $0.isNumber }) ?? 0
            var extendedIngredients: [ExtendedIngredient] = []
            for cell in tableViewIngredients.visibleCells {
                if let cell = cell as? IngredientCell,
                   let nameIngredient = cell.nameField.text,
                   nameIngredient != "",
                   let quantityField = cell.quantityField.text,
                   quantityField != ""
                {
                    let amount = Double(quantityField.prefix { $0.isNumber } ) ?? 0.0
                    let unit = quantityField.drop { $0.isNumber }.trimmingCharacters(in: .whitespaces)
                    extendedIngredients.append(ExtendedIngredient(name: nameIngredient,
                                                                  amount: amount,
                                                                  unit: unit,
                                                                  consistency: "TEST",
                                                                  image: "TEST"))
                }
            }
            
            var newRecipe = RecipeDetail(id: 9999999,
                                         title: title,
                                         image: "TEST",
                                         spoonacularScore: 5.0,
                                         instructions: "TEST instructions",
                                         preparationMinutes: 0,
                                         cookingMinutes: 0,
                                         readyInMinutes: cookingMinutes,
                                         extendedIngredients: extendedIngredients,
                                         sourceName: "Your Recipe",
                                         sourceUrl: "Your account",
                                         vegetarian: false,
                                         glutenFree: false,
                                         servings: servings)
            StorageManager.shared.saveMyRecipe(recipe: newRecipe)
            print(newRecipe)
        }
    }
    
    
}

//MARK: UIImagePickerControllerDelegate
extension CreateRecipeViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
            imageView.contentMode = .scaleAspectFill
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

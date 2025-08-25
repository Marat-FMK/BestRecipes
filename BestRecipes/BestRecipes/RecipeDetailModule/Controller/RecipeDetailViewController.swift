//
//  ViewController.swift
//  BestRecipes
//
//  Created by Marat Fakhrizhanov on 11.08.2025.
//



import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: RecipeDetail?
    
    var enRecipe = RecipeDetail(id: 0000, title: "", image: "", spoonacularScore: 0.0, instructions: "", preparationMinutes: nil, cookingMinutes: nil, readyInMinutes: 1, extendedIngredients: [ExtendedIngredient(name: "", amount: 0.0, unit: "", consistency: "", image: "")], sourceName: "", sourceUrl: "", vegetarian: false, glutenFree: false, servings: 0)
    
    var ruRecipe = RecipeDetail(id: 0000, title: "", image: "", spoonacularScore: 0.0, instructions: "", preparationMinutes: nil, cookingMinutes: nil, readyInMinutes: 1, extendedIngredients: [ExtendedIngredient(name: "", amount: 0.0, unit: "", consistency: "", image: "")], sourceName: "", sourceUrl: "", vegetarian: false, glutenFree: false, servings: 0)
    
    private var isTranslated = false // Флаг для отслеживания состояния перевода
    
    //MARK: - UI Components
    //MARK: Navigation Bar Items
    
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
        label.text = "Recipe Detail"
        return label
    }()
    
    // Новая кнопка Translate
    private let translateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Translate", for: .normal)
        button.setTitleColor(.black, for: .normal) // Черный текст
        button.titleLabel?.font = UIFont(name: Constants.Fonts.poppinsSemiBold, size: 14)
        button.backgroundColor = .gray // Серый фон
        button.layer.borderColor = .init(red: 1, green: 0, blue: 0, alpha: 0.5)// Коралловый контур
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        return button
    }()
    
    //MARK: Main
    private let recipeDetailTable: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RecipeDetailAboutCell.self, forCellReuseIdentifier: RecipeDetailAboutCell.identifier)
        tableView.register(RecipeDetailInstructionsCell.self, forCellReuseIdentifier: RecipeDetailInstructionsCell.identifier)
        tableView.register(RecipeDetailTableViewCell.self, forCellReuseIdentifier: RecipeDetailTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 1000
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.recipeDetailTable.delegate = self
        self.recipeDetailTable.dataSource = self
        self.enRecipe = self.recipe!
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
        
        // Добавляем кнопку перевода в navigation bar
        let translateBarButton = UIBarButtonItem(customView: translateButton)
        navigationItem.rightBarButtonItem = translateBarButton
        
        backButton.addTarget(self, action: #selector(backButtonTapped(sender:)), for: .touchUpInside)
        translateButton.addTarget(self, action: #selector(translateButtonTapped(sender:)), for: .touchUpInside)
        
        //MARK: UI
        view.addSubview(recipeDetailTable)
        NSLayoutConstraint.activate([
            recipeDetailTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            recipeDetailTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
            recipeDetailTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            recipeDetailTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //MARK: - BackButton Func
    @objc func backButtonTapped(sender: UIButton) {
        sender.buttonTappedAnimate()
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Translate Button Func
    @objc func translateButtonTapped(sender: UIButton) {
        sender.buttonTappedAnimate()
        translateRecipeText()
    }
    
    // Функция для перевода текста рецепта
    private func translateRecipeText() {
        // Здесь вы можете реализовать логику перевода
        // Например, используя API переводчика или локальный перевод
//        enRecipe = recipe! // ❌🔥!!??!?!?!?!?!?!
        
        
        
        if self.isTranslated {
            isTranslated.toggle()
            self.recipe = self.enRecipe
            // Возврат к оригинальному тексту
            self.revertToOriginal()
            DispatchQueue.main.async {
                self.translateButton.setTitle("Translate", for: .normal)
                self.reloadData()
            }
        } else {
            StorageManager.shared.translateRecipe(recipe: enRecipe) { resultTranslatedRecipe in
                self.isTranslated.toggle()
                self.ruRecipe = resultTranslatedRecipe
                // Вызов функции перевода (замените на вашу реализацию)
                self.performTranslation()
                DispatchQueue.main.async {
                    self.recipe = self.ruRecipe
                    self.translateButton.setTitle("Original", for: .normal)
                    self.reloadData()
                }
            }
        }
            
    }
    
    private func performTranslation() {
        // Реализуйте здесь логику перевода текста рецепта
        // Это может быть вызов API, использование фреймворка перевода и т.д.
        print("Translating recipe text...")
        
        // Пример: обновление текста в модели рецепта
        // recipe?.instructions = translatedText
    }
    
    private func revertToOriginal() {
        // Возврат к оригинальному тексту
        print("Reverting to original text...")
        
        // Пример: восстановление оригинального текста
        // recipe?.instructions = originalInstructions
    }
    
    // Функция для обновления данных (как вы requested)
    func reloadData() {
        recipeDetailTable.reloadData()
    }
}










// V1 -->>

//class RecipeDetailViewController: UIViewController {
//    
//    var recipe: RecipeDetail?
//    
//    //MARK: - UI Components
//    //MARK: Navigation Bar Items
//    
//    private let backButton: UIButton = {
//        let backButton = UIButton()
//        backButton.translatesAutoresizingMaskIntoConstraints = false
//        backButton.setImage(UIImage(named: Constants.Icons.arrowLeft), for: .normal)
//        return backButton
//    }()
//    
//    private let navigationBarTitle: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textAlignment = .center
//        label.font = UIFont(name: Constants.Fonts.poppinsBold, size: 24)
//        label.text = "Recipe Detail"
//        return label
//    }()
//    
//    //MARK: Main
//    private let recipeDetailTable: UITableView = {
//        let tableView = UITableView()
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.register(RecipeDetailAboutCell.self, forCellReuseIdentifier: RecipeDetailAboutCell.identifier)
//        tableView.register(RecipeDetailInstructionsCell.self, forCellReuseIdentifier: RecipeDetailInstructionsCell.identifier)
//        tableView.register(RecipeDetailTableViewCell.self, forCellReuseIdentifier: RecipeDetailTableViewCell.identifier)
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 1000
//        tableView.separatorStyle = .none
//        tableView.showsVerticalScrollIndicator = false
//        return tableView
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        self.recipeDetailTable.delegate = self
//        self.recipeDetailTable.dataSource = self
//    }
//    
//    override func viewWillAppear(_ animated: Bool)  {
//        super.viewWillAppear(animated)
//        self.tabBarController?.setTabBarHidden(true, animated: false)
//        (tabBarController as? TabBarViewController)?.customTabBar.isHidden = true
//        navigationController?.setNavigationBarHidden(false, animated: true)
//    }
//    
//    func setupUI() {
//        view.backgroundColor = Constants.Colors.Neutral.white0
//        
//        //MARK: NavigationBar UI
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
//        navigationItem.titleView = navigationBarTitle
//        backButton.addTarget(self, action: #selector(backButtonTapped(sender:)), for: .touchUpInside)
//        //MARK: UI
//            view.addSubview(recipeDetailTable)
//        NSLayoutConstraint.activate([
//            recipeDetailTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            recipeDetailTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
//            recipeDetailTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
//            recipeDetailTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//    
////MARK: - BackButton Func
//    @objc func backButtonTapped(sender: UIButton) {
//        sender.buttonTappedAnimate()
//        navigationController?.popViewController(animated: true)
//    }
//}
//
extension RecipeDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeDetailAboutCell.identifier, for: indexPath) as! RecipeDetailAboutCell
            if let recipe = self.recipe {
                cell.configure(with: recipe)
            }
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeDetailInstructionsCell.identifier, for: indexPath) as! RecipeDetailInstructionsCell
            if let recipe = self.recipe {
                cell.configure(with: recipe)
            }
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeDetailTableViewCell.identifier, for: indexPath) as! RecipeDetailTableViewCell
            cell.selectionStyle = .none
            if let recipe = self.recipe {
                cell.configure(with: recipe, counter: indexPath.row - 2)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let counter = recipe?.extendedIngredients.count else { return 2 }
        return 2 + counter
    }
}

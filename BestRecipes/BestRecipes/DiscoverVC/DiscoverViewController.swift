
import UIKit

class DiscoverViewController: UIViewController {
    
    let storageManager = StorageManager.shared
    
    //MARK: - Create UI
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Saved recipes"
        label.textColor = .label
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        SetDelegatas()
        loadTFavoriteRecepies()
        StorageManager.shared.removeDuplicateFavorites()
    }
    
    
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        
    }
    
    // MARK: Set Delegatas
    
    func SetDelegatas() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: "TrendingCell")
    }
    
    private func loadTFavoriteRecepies() {
        print("🔄 Loading trending data...")
        DispatchQueue.main.async {
            print("✅ Data loaded: \(StorageManager.shared.favoriteRecipes.count) items")
            self.collectionView.reloadData()
        }
    }
    
    @objc func saveButtonTapped(sender: UIButton) {
        sender.buttonTappedAnimate()
        let index = sender.tag
        guard index < StorageManager.shared.favoriteRecipes.count else {
            print("❌ Index out of bounds")
            return
        }
        let recipe = StorageManager.shared.favoriteRecipes[index]
        StorageManager.shared.deleteFavoriteRecipe(recipe: recipe)
        DispatchQueue.main.async {
                self.collectionView.performBatchUpdates({
                    self.collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
                }, completion: nil)
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTFavoriteRecepies()
    }
    
    //MARK: - setConstraints
    
    private func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 35),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
        ])
        
        
    }
}

// MARK: Extension ViewDelegate

extension DiscoverViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StorageManager.shared.favoriteRecipes.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCell", for: indexPath) as! TrendingCell
        let recepie = StorageManager.shared.favoriteRecipes[indexPath.item]
        cell.configureForSavedVC(with: recepie)
        cell.saveButton.addTarget(self, action: #selector(saveButtonTapped(sender:)), for: .touchUpInside)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 258)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let vc = RecipeDetailViewController()
            vc.recipe = StorageManager.shared.favoriteRecipes[indexPath.item]
            navigationController?.pushViewController(vc, animated: true)
        }
    
}

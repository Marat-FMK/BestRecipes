
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
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCell", for: indexPath) as! TrendingCell
        if storageManager.favoriteRecipes.isEmpty {
            return cell
        } else {
            let recepie = storageManager.favoriteRecipes[indexPath.item]
            cell.configure(with: recepie)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 258)
    }

}

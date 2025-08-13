//
//  RecepieCell.swift
//  BestRecipes
//
//  Created by Евгений Васильев on 12.08.2025.
//
import UIKit

class PopularRecepieCell: UICollectionViewCell {
    
    let backgroundImageView : UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .neutral20
        return view
    }()
    
    let roundImageView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "shawarma_image")
        view.layer.cornerRadius = 55
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Chicken and\nVegetable wrap"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let saveButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.Images.bookmarkButtonImageInactive), for: .normal)
        button.backgroundColor = .white0
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "Time"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .left
        label.textColor = .neutral60
        return label
    }()
    
    let durationLabel : UILabel = {
        let label = UILabel()
        label.text = "5 mins"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    //MARK: - Save Func
    @objc func saveButtonTapped(sender : UIButton) {
        sender.buttonTappedAnimate()
    }
    
    //MARK: - Setup
    
    let identifier = "TrendingCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(roundImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(saveButton)
        contentView.addSubview(timeLabel)
        contentView.addSubview(durationLabel)
    }
    
    private func setConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor,constant: 55),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        roundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            roundImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            roundImageView.topAnchor.constraint(equalTo: topAnchor),
            roundImageView.heightAnchor.constraint(equalToConstant: 110),
            roundImageView.widthAnchor.constraint(equalToConstant: 110)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: roundImageView.bottomAnchor, constant: 12),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            saveButton.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -12),
            saveButton.heightAnchor.constraint(equalToConstant: 32),
            saveButton.widthAnchor.constraint(equalToConstant: 32)
        ])
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15)
        ])
        
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            durationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            durationLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 6)
        ])
        
    }
}




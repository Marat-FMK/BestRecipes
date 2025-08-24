//
//  CreatorCell.swift
//  BestRecipes
//
//  Created by Евгений Васильев on 12.08.2025.
//
import UIKit

class CreatorCell: UICollectionViewCell {
    
//    let backgroundImageView : UIImageView = {
//        let view = UIImageView()
//        view.layer.cornerRadius = 55
//        view.image = UIImage(named: "creatorAvatarImage")
//        return view
//    }()
    
    private let backgroundImageView: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 90)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let creatorLabel : UILabel = {
        let label = UILabel()
        label.text = "Ify's Kitchen"
        label.numberOfLines = 1
        label.font = UIFont(name: Constants.Fonts.poppinsSemiBold, size: 12)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    let identifier = "CreatorCell"
    
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
        contentView.addSubview(creatorLabel)
    }
    
    private func setConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 110)
        ])
        
        creatorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            creatorLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 8),
            creatorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
    }
    
    func configure(country: String) {
        creatorLabel.text = country
        var imageString = ""
        
        switch country {
        case "African": imageString = "🇿🇦"
        case "Asian": imageString = ""
        case "American": imageString = "🇺🇸"
        case "British": imageString = "🇬🇧"
        case "Cajun": imageString = "🇺🇸"
        case "Caribbean": imageString = "🏝️"
        case "Chinese": imageString = "🇨🇳"
        case "EasternEuropean": imageString = "🇵🇱"
        case "European": imageString = "🇪🇺"
        case "French": imageString = "🇫🇷"
        case "German": imageString = "🇩🇪"
        case "Greek": imageString = "🇬🇷"
        case "Indian": imageString = "🇮🇳"
        case "Irish": imageString = "🇮🇪"
        case "Italian": imageString = "🇮🇹"
        case "Japanese": imageString = "🇯🇵"
        case "Jewish": imageString = "✡️"
        case "Korean": imageString = "🇰🇷"
        case "LatinAmerican": imageString = "🌎"
        case "Mediterranean": imageString = "🌊"
        case "Mexican": imageString = "🇲🇽"
        case "MiddleEastern": imageString = "🕌"
        case "Nordic": imageString = "❄️"
        case "Southern": imageString = "🍗"
        case "Spanish": imageString = "🇪🇸"
        case "Thai": imageString = "🇹🇭"
        case "Vietnamese": imageString = "🇻🇳"
        default: imageString = "🌐"
        }
        
        backgroundImageView.text = imageString
    }
}






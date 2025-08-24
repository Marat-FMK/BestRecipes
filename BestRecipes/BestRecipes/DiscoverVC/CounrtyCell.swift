//
//  CounrtyCell.swift
//  BestRecipes
//
//  Created by Marat Fakhrizhanov on 24.08.2025.
//


import UIKit

class CountryCell: UITableViewCell {
    
    static let identifier = "CountryCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray5
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(red: 1.0, green: 0.36, blue: 0.36, alpha: 1.0).cgColor // coral
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let flagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28) // побольше для флага
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubview(flagLabel)
        containerView.addSubview(countryLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerView.heightAnchor.constraint(equalToConstant: 60),
            
            flagLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            flagLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            flagLabel.widthAnchor.constraint(equalToConstant: 40),
            
            countryLabel.leadingAnchor.constraint(equalTo: flagLabel.trailingAnchor, constant: 12),
            countryLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            countryLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with country: String) {
        countryLabel.text = country
        flagLabel.text = emojiForCountry(country)
    }
    
    // MARK: - Сопоставление страна → флаг
    private func emojiForCountry(_ country: String) -> String {
        switch country {
        case "African": return "🇿🇦"
        case "Asian": return ""
        case "American": return "🇺🇸"
        case "British": return "🇬🇧"
        case "Cajun": return "🇺🇸"
        case "Caribbean": return "🏝️"
        case "Chinese": return "🇨🇳"
        case "EasternEuropean": return "🇵🇱"
        case "European": return "🇪🇺"
        case "French": return "🇫🇷"
        case "German": return "🇩🇪"
        case "Greek": return "🇬🇷"
        case "Indian": return "🇮🇳"
        case "Irish": return "🇮🇪"
        case "Italian": return "🇮🇹"
        case "Japanese": return "🇯🇵"
        case "Jewish": return "✡️"
        case "Korean": return "🇰🇷"
        case "LatinAmerican": return "🌎"
        case "Mediterranean": return "🌊"
        case "Mexican": return "🇲🇽"
        case "MiddleEastern": return "🕌"
        case "Nordic": return "❄️"
        case "Southern": return "🍗"
        case "Spanish": return "🇪🇸"
        case "Thai": return "🇹🇭"
        case "Vietnamese": return "🇻🇳"
        default: return "🌐"
        }
    }
    
    // MARK: - Анимация при выборе
    func animateSelection() {
        UIView.animate(withDuration: 0.1,
                       animations: {
            self.containerView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.containerView.transform = .identity
            }
        })
    }
}


//class CountryCell: UITableViewCell {
//    
//    static let identifier = "CountryCell"
//    
//    private let containerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.systemGray5
//        view.layer.cornerRadius = 12
//        view.layer.borderWidth = 2
//        view.layer.borderColor = UIColor(red: 1.0, green: 0.36, blue: 0.36, alpha: 1.0).cgColor // coral
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    private let flagImageView: UIImageView = {
//        let iv = UIImageView()
//        iv.contentMode = .scaleAspectFit
//        iv.layer.cornerRadius = 6
//        iv.clipsToBounds = true
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        return iv
//    }()
//    
//    private let countryLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//        label.textColor = .black
//        label.textAlignment = .left
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    // MARK: Init
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        selectionStyle = .none
//        backgroundColor = .clear
//        contentView.addSubview(containerView)
//        containerView.addSubview(flagImageView)
//        containerView.addSubview(countryLabel)
//        
//        NSLayoutConstraint.activate([
//            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
//            containerView.heightAnchor.constraint(equalToConstant: 60),
//            
//            flagImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
//            flagImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            flagImageView.widthAnchor.constraint(equalToConstant: 40),
//            flagImageView.heightAnchor.constraint(equalToConstant: 30),
//            
//            countryLabel.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor, constant: 12),
//            countryLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
//            countryLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
//        ])
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func configure(with country: String) {
//        countryLabel.text = country
//        
//        // ищем флаг в ассетах по имени страны (например "Italy.png")
//        if let image = UIImage(named: country) {
//            flagImageView.image = image
//        } else {
//            // если нет, ставим 🌍
//            flagImageView.image = UIImage(systemName: "globe.europe.africa.fill")
//            flagImageView.tintColor = .black
//        }
//    }
//    
//    // MARK: - Анимация при выборе
//    func animateSelection() {
//        UIView.animate(withDuration: 0.1,
//                       animations: {
//            self.containerView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
//        }, completion: { _ in
//            UIView.animate(withDuration: 0.1) {
//                self.containerView.transform = .identity
//            }
//        })
//    }
//}

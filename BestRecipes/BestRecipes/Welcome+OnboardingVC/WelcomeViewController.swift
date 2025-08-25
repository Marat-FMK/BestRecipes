//
//  ViewController.swift
//  FistVC Challenge
//
//  Created by Евгений Васильев on 11.08.2025.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    //MARK: - Create UI
    
    let backgroundImageView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Constants.Images.onboardingStartPage)
        return view
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Best\nRecepie"
        label.font = UIFont.systemFont(ofSize: 56, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let smallLabel : UILabel = {
        let label = UILabel()
        label.text = "Find best recepies for cooking"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    let topLabel : UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "100k+ ",attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .semibold),.foregroundColor: UIColor.white])
        attributedText.append(NSAttributedString(
        string: "Premium Recepies",
        attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .regular),.foregroundColor: UIColor.white]))
        label.attributedText = attributedText
        return label
    }()
    
    let topStar : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "star")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let topStackView : UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 3
        return view
    }()
    
    let getStartButton : UIButton = {
        let button = UIButton()
        button.setTitle("Get started", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = UIColor.primary50
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(getStartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(titleLabel)
        view.addSubview(smallLabel)
        view.addSubview(topStackView)
        topStackView.addArrangedSubview(topStar)
        topStackView.addArrangedSubview(topLabel)
        view.addSubview(getStartButton)
    }
    
    //MARK: - Action Func
    
    @objc func getStartButtonTapped(sender: UIButton) {
        sender.buttonTappedAnimate()
        let vc = OnboardingViewController()
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
        
        UserDefaults.standard.set(true, forKey: Constants.UDConstants.onboardingViewed) // -->> Save to UD
    }
    
    //MARK: - setConstraints
    
    private func setConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -173)
        ])
        
        smallLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            smallLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            smallLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16),
            topStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        getStartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            getStartButton.topAnchor.constraint(equalTo: smallLabel.bottomAnchor, constant: 32),
            getStartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 109.5),
            getStartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -109.5),
            getStartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -44)
        ])
    }
}


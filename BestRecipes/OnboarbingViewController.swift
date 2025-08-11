//
//  OnboarbingViewController.swift
//  FistVC Challenge
//
//  Created by Евгений Васильев on 11.08.2025.
//
import UIKit

class OnboarbingViewController : UIViewController {
    
    private let onboardingData: [(backgroundImage: String, title: String, highlightedText: String)] = [
        ("page1Image", "Recipes from\nall", "over the\nWorld"),
        ("page2Image", "Recipes with\n", "each and every\ndetail"),
        ("page3Image", "Cook it now or\n", "safe it later")
    ]
    
    let numberOfPages = 3
    
    private var currentPage = 0
    
    //MARK: - Create UI
    
    let backgroundImageview : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "page1Image")
        return view
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        let attributedText = NSMutableAttributedString(string: "Recepies from\nall",attributes: [.font: UIFont.systemFont(ofSize: 40, weight: .semibold),.foregroundColor: UIColor.white])
        attributedText.append(NSAttributedString(
            string: " over the\nWorld",
            attributes: [.font: UIFont.systemFont(ofSize: 40, weight: .semibold),.foregroundColor: UIColor.secondary0]))
        label.attributedText = attributedText
        return label
    }()
    
    lazy var indicatorStackView : UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 10
        for i in 0...2 {
            let indicator = UIView()
            indicator.backgroundColor = UIColor(named: "lightGrayColor")
            indicator.layer.cornerRadius = 5
            view.addArrangedSubview(indicator)
        }
        return view
    }()
    
    let continueButton : UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.backgroundColor = UIColor.primary50
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let skipButton : UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updatePageIndicators()
    }
    
    private func setupViews() {
        view.addSubview(backgroundImageview)
        view.addSubview(titleLabel)
        view.addSubview(indicatorStackView)
        view.addSubview(continueButton)
        view.addSubview(skipButton)
    }
    
    //MARK: - Update UI Func
    
    private func updateUI() {
        DispatchQueue.main.async { [self] in
            let newData = onboardingData[currentPage]
            let attributedText = NSMutableAttributedString(
                string: newData.title,
                attributes: [.font: UIFont.systemFont(ofSize: 40, weight: .semibold), .foregroundColor: UIColor.white]
            )
            attributedText.append(NSAttributedString(
                string: newData.highlightedText,
                attributes: [.font: UIFont.systemFont(ofSize: 40, weight: .semibold), .foregroundColor: UIColor.secondary0]
            ))
            let newTitle = (currentPage == numberOfPages - 1) ? "Start cooking" : "Continue"
            performAnimatedUpdate(
                for: backgroundImageview,
                label: titleLabel,
                button: continueButton,
                newImage: UIImage(named: newData.backgroundImage),
                newText: attributedText,
                newButtonTitle: newTitle
            )
            updatePageIndicators()
        }
    }
    
    private func updatePageIndicators() {
        for (index, view) in indicatorStackView.arrangedSubviews.enumerated() {
            if index == currentPage {
                makeGradient(view: view)
            } else {
                view.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
                view.backgroundColor = UIColor(named: "lightGrayColor")
            }
        }
    }
    
    //MARK: - Action Func
    
    @objc private func continueButtonTapped(sender : UIButton) {
        sender.buttonTappedAnimate()
        if currentPage < numberOfPages - 1 {
            currentPage += 1
            updateUI()
        } else {
            // Завершение онбординга и переход к основному экрану
            print("Onboarding completed")
        }
    }
    
    func makeGradient(view : UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.primary20.cgColor, UIColor.secondary20.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.cornerRadius = view.layer.cornerRadius
        gradientLayer.masksToBounds = true
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func performAnimatedUpdate(
        for imageView: UIImageView,
        label: UILabel,
        button: UIButton,
        newImage: UIImage?,
        newText: NSAttributedString,
        newButtonTitle: String
    ) {
        UIView.transition(with: imageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            imageView.image = newImage
        })
        
        UIView.transition(with: label, duration: 0.5, options: .transitionCrossDissolve, animations: {
            label.attributedText = newText
        })
        
        UIView.transition(with: button, duration: 0.3, options: .transitionCrossDissolve, animations: {
            button.setTitle(newButtonTitle, for: .normal)
        })
    }
    
    //MARK: - setConstraints
    
    private func setConstraints() {
        backgroundImageview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageview.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -162)
        ])
        
        indicatorStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicatorStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            indicatorStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 110),
            indicatorStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -110),
            indicatorStackView.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: indicatorStackView.bottomAnchor, constant: 32),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 87),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -87),
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -46)
        ])
        
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 12),
            skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 170),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -170),
            skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -22)
        ])
    }
}

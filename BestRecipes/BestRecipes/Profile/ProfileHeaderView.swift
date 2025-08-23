//
//  ProfileHeaderView.swift
//  BestRecipes
//
//  Created by Rustam Basanov on 24.08.2025.
//

import UIKit

protocol ProfileHeaderViewDelegate: AnyObject {
    func didSelectImage(_ image: UIImage)
}

class ProfileHeaderView: UIView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    weak var delegate: ProfileHeaderViewDelegate?
    private weak var parentVC: UIViewController?  // чтобы презентовать picker
    
    init(parentVC: UIViewController) {
        self.parentVC = parentVC
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "creatorAvatarImage")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .secondarySystemBackground
        iv.layer.borderColor = UIColor.lightGray.cgColor
        iv.layer.borderWidth = 2
        return iv
    }()
    
    private let addButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        btn.tintColor = .systemBlue
        return btn
    }()
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(addButton)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 109),
            imageView.heightAnchor.constraint(equalToConstant: 109),
            
            addButton.widthAnchor.constraint(equalToConstant: 30),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -5),
            addButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -5),
        ])
        
        addButton.addTarget(self, action: #selector(showImagePickerOptions), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.width / 2
        addButton.layer.cornerRadius = addButton.frame.width / 2
        addButton.clipsToBounds = true
        addButton.backgroundColor = .white
    }
    
    // MARK: - Image Picker
    @objc private func showImagePickerOptions() {
        guard let parentVC = parentVC else { return }
        
        let alert = UIAlertController(title: "Выбери источник", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Камера", style: .default) { _ in
                self.openImagePicker(sourceType: .camera)
            })
        }
        
        alert.addAction(UIAlertAction(title: "Галерея", style: .default) { _ in
            self.openImagePicker(sourceType: .photoLibrary)
        })
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        parentVC.present(alert, animated: true)
    }
    
    private func openImagePicker(sourceType: UIImagePickerController.SourceType) {
        guard let parentVC = parentVC else { return }
        
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = self
        picker.allowsEditing = true
        parentVC.present(picker, animated: true)
    }
    
    // MARK: - Delegate
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            imageView.image = image
            delegate?.didSelectImage(image)
        } else if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            delegate?.didSelectImage(image)
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

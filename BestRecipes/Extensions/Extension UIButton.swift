//
//  Extension UIButton Animate on tap.swift
//  FistVC Challenge
//
//  Created by Евгений Васильев on 11.08.2025.
//
import UIKit

extension UIButton {
    func buttonTappedAnimate() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.transform = .identity
            }
        }
    }
}


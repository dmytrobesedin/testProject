//
//  UIView+Rotate.swift
//  testProject
//
//  Created by Дмитрий Беседин on 20.02.2022.
//

import UIKit

extension UIView {
    func makeVertical(){
        transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
    }
}

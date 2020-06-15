//
//  UIImageViewExtension.swift
//  RatesApp
//
//  Created by Adriana Epure on 15/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import UIKit

extension UIImageView {
    func maskCircle(anyImage: UIImage) {
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        
        // make square(* must to make circle),
        // resize(reduce the kilobyte) and
        // fix rotation.
        self.image = anyImage
    }
}

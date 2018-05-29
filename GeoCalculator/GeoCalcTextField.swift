//
//  GeoCalcTextField.swift
//  GeoCalculator
//
//  Created by geethanjali on 5/28/18.
//  Copyright © 2018 edu.gvsu.cis. All rights reserved.
//

import UIKit


class GeoCalcTextField: UITextField {
    override func awakeFromNib() {
        
        self.tintColor = FOREGROUND_COLOR
        self.layer.borderWidth = 1.0
        self.layer.borderColor = FOREGROUND_COLOR.cgColor
        self.layer.cornerRadius = 5.0
        
        self.textColor = FOREGROUND_COLOR
        self.backgroundColor = UIColor.clear
        self.borderStyle = .roundedRect
        
        guard let ph = self.placeholder  else {
            return
        }
        self.attributedPlaceholder = NSAttributedString(string: ph, attributes:[NSAttributedStringKey.foregroundColor: FOREGROUND_COLOR])
      
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

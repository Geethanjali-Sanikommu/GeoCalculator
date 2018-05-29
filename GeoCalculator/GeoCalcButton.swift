//
//  GeoCalcButton.swift
//  GeoCalculator
//
//  Created by geethanjali on 5/28/18.
//  Copyright © 2018 edu.gvsu.cis. All rights reserved.
//

import UIKit

class GeoCalcButton: UIButton {

    override func awakeFromNib() {
        self.backgroundColor = FOREGROUND_COLOR
        self.tintColor = BACKGROUND_COLOR
        self.layer.borderWidth = 1.0
        self.layer.borderColor = FOREGROUND_COLOR.cgColor
        self.layer.cornerRadius = 5.0
    }
}

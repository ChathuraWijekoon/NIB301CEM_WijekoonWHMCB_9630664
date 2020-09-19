//
//  CustomSection.swift
//  WijekoonWHMCB-COBSCCOMP191P-006
//
//  Created by Chathura Wijekoon on 9/18/20.
//  Copyright © 2020 Chathura Wijekoon. All rights reserved.
//

import UIKit

class CustomSection: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSection()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSection()
    }
    
    private func setupSection() {
        layer.cornerRadius = frame.size.height/12
    }
}

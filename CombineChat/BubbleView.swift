//
//  BubbleView.swift
//  CombineChat
//
//  Created by Thom Ritterfeld on 6/7/19.
//  Copyright © 2019 Thom Ritterfeld. All rights reserved.
//

import UIKit

class BubbleView: UIView {
    @IBOutlet var layoutLeft: NSLayoutConstraint?
    @IBOutlet var layoutRight: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.layer.cornerRadius = 12
    }
}

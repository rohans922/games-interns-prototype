//
//  NumbersView.swift
//  Prototype
//
//  Copyright © 2020 2020 Interns. All rights reserved.
//

import UIKit

class ClockView: UIView {
    
    @IBOutlet var clockView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ClockView", owner: self, options: nil)
        addSubview(clockView)
        clockView.frame = self.bounds
        clockView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        // Creates the border for the clock:
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.clipsToBounds = true
    }
    
    func setRadius() {
        self.layer.cornerRadius = clockView.frame.height / 2
        self.layer.borderWidth = 3;
        clockView.frame = self.bounds
    }
    
    // Add function to rotate hands
    
}

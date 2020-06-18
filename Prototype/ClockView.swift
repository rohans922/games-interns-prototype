//
//  NumbersView.swift
//  Prototype
//
//  Copyright © 2020 2020 Interns. All rights reserved.
//

import UIKit

class ClockView: UIView {
    
    @IBOutlet var clockView: UIView!
    @IBOutlet weak var hourHand: UIImageView!
    @IBOutlet weak var minuteHand: UIImageView!
    private let oneStepRadians: CGFloat = 0.785398 // 45 degrees in radians
    
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
        self.layer.borderWidth = 3
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    // Add function to rotate hands
    
}

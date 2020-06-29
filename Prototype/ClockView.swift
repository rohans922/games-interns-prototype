//
//  NumbersView.swift
//  Prototype
//
//  Copyright © 2020 2020 Interns. All rights reserved.
//

import UIKit

class ClockView: UIView {
    
    @IBOutlet var clockView: UIView!
    @IBOutlet weak var linesImageView: UIImageView!
    
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
        clockView.frame = self.bounds
    }
    
    func showLines(_ number: String) {
        linesImageView.image = UIImage(named: ("lines-" + number))
        UIView.animate(withDuration:0.3, animations: {
            self.linesImageView.alpha = 1.0
        })
    }
    
    func hideLines() {
        UIView.animate(withDuration:0.3, animations: {
            self.linesImageView.alpha = 0.0
        })
    }
    
    // Add function to rotate hands
    
}

//
//  NumbersView.swift
//  Prototype
//
//  Copyright © 2020 2020 Interns. All rights reserved.
//

import UIKit

class NumbersView: UIView {
    
    @IBOutlet var numbersView: UIView!
    
    @IBOutlet weak var image1: UIView!
    @IBOutlet var oneGestureRecognizer: UIPanGestureRecognizer!
    
    
    //@IBOutlet var numbers: [UIView]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("NumbersView", owner: self, options: nil)
        addSubview(numbersView)
        numbersView.frame = self.bounds
        numbersView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBAction func didMoveOne(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: image1)
        image1.center.x += translation.x
        image1.center.y += translation.y
        sender.setTranslation(.zero, in: image1)
        print(image1.center.x)
        print(image1.center.y)
    }
    
    
    // Add function to swap .image values in numbers array
    
}

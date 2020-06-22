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
    @IBOutlet weak var image2: UIView!
    
    @IBOutlet var oneGestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet var twoGR: UIPanGestureRecognizer!
    
    //@IBOutlet var numbers: [UIView]!
 
    var x_1 : Int = 0
    
    
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
    
    
    //added function to move (images) views
    @IBAction func didMoveOne(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: image1)
        image1.center.x += translation.x
        image1.center.y += translation.y
        sender.setTranslation(.zero, in: image1)
//        print(image1.center.x)
//        print(image1.center.y)
        
        x_1 = Int(image1.center.x)
       
        
        let translation2 = sender.translation(in: image2)
        image2.center.x += translation2.x
        image2.center.y += translation2.y
        sender.setTranslation(.zero, in: image2)
//        print(image2.center.x)
//        print(image2.center.y)
        
                
        }
    }

    
    // Function to swap 2 (image) views
    

func swapPlaces(xcoor:Int) {
    
    if(xcoor == 0){
        
    }
    
    }


    


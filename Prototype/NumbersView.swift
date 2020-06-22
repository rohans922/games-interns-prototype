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
 
    var view1Frame: CGRect?
    var view2Frame: CGRect?
    
    
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
        
        print(image1.center.x)
        print(image1.center.y)
        
       
       
        
        let translation2 = sender.translation(in: image2)
        image2.center.x += translation2.x
        image2.center.y += translation2.y
        sender.setTranslation(.zero, in: image2)
        
        print(image2.center.x)
        print(image2.center.y)
        
        if(image1.center.x >= image2.center.x - 2 || image1.center.x <= image2.center.x + 2){
                
                swapPlaces()
            }
                    
        }
    
    
    
    func swapPlaces() -> Void {
        view1Frame = image1.frame;
        view2Frame = image2.frame;

        if (image1.frame.intersects(image2.frame)) {
            
            image1.frame = view2Frame!;
            image2.frame = view1Frame!;
           
        }
    }
    
    }

    
    // Function to swap 2 (image) views
    




    


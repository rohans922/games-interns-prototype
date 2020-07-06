//
//  RulesViewController.swift
//  Prototype
//
//  Created by Shandler Mason on 7/6/20.
//  Copyright © 2020 2020 Interns. All rights reserved.
//

import UIKit

class RulesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showAnimate()
        self.view.backgroundColor=UIColor.black.withAlphaComponent(0.5) //makes the background color transparent

        //Background view color behind popup to make it look like an actual popup dimming the background
        //self.view.backgroundColor = UIColor.black
    }

    @IBAction func closeRulesPopUp(_ sender: Any) {
        print("close")
        self.removeAnimate()
    
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3) //make view bigger at first
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0) //then scale view back down
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3) //make view go from smaller to bigger as if its exciting the screen
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished) //when its finished remove it from the view
                {
                    self.view.removeFromSuperview()
                }
        });
    }
    
   
}

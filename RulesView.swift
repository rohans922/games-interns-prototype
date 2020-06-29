//
//  RulesView.swift
//  Prototype
//
//  Created by Shandler Mason on 6/29/20.
//  Copyright © 2020 2020 Interns. All rights reserved.
//

import UIKit

class RulesView: UIView {
    
@IBOutlet weak var RulesText: UITextView!
@IBOutlet weak var startGame: UIButton!
@IBOutlet weak var RulesLabel: UILabel!
@IBOutlet weak var RulesByLine: UITextView!
    
    
    func viewDidLoad (){
        
        
    }
    
    func displayText () {
        
        self.RulesLabel.text = "Rules"
        self.RulesByLine.text = "Organize the frames in the correct sequence to reveal an animation!"
        self.RulesText.text = " • The animation starts from the top, under the film camera icon. • Tap and hold a frame to see where it can be switched. Frames can only switch with those that are highlighted. • Drag and drop frames to switch them. • You can preview your animation each time you switch frames. You can also tap it to replay."

        RulesLabel.font = UIFont(name:"NYTKarnak Condensed", size: 36.0)
        RulesByLine.font = UIFont(name: "NYTFranklin", size: 16.0)
        RulesText.font = UIFont(name: "NYTFranklin", size: 16.0)
        RulesText.textColor = UIColor.gray

        
    }
    
}






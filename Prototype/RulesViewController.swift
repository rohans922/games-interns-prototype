//
//  RulesViewController.swift
//  Prototype
//
//  Created by Rohan Shaiva on 7/6/20.
//  Copyright © 2020 2020 Interns. All rights reserved.
//

import UIKit

protocol RulesViewControllerDelegate {
    func resetPuzzle()
    func closed()
}

class RulesViewController: UIViewController {

    private var delegate: RulesViewControllerDelegate?
    private var first: Bool?
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var rulesTitleLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var listLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    var rulesArray = [
        "Drag and drop to switch frames.",
        "The selected frame can only be switched with grey frames.",
        "Press the play button to preview the final animation.",
        "The animation begins at the top of the reel"
    ]
    let bullet = "•  "
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TEST")
        self.showAnimate()
        self.view.backgroundColor=UIColor.black.withAlphaComponent(0.5) //makes the background color transparent
        mainView.layer.cornerRadius = 5
        rulesTitleLabel.font = UIFont(name: "NYTKarnakCondensed-Bold", size: 39)
        instructionLabel.font = UIFont(name: "NYTFranklin-Medium", size: 16)
        listLabel.textColor = UIColor(red: 0.349, green: 0.349, blue: 0.388, alpha: 1)
        rulesArray = rulesArray.map {return bullet + $0}

        var attributes =
        [NSAttributedString.Key: Any]()
        attributes[.font] = UIFont(name: "NYTFranklin-Medium", size: 16)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.5
        paragraphStyle.headIndent = (bullet as NSString).size(withAttributes: attributes).width
        attributes[.paragraphStyle] = paragraphStyle
        
        let rulesString = rulesArray.joined(separator: "\n")
        
        listLabel.attributedText = NSAttributedString(string: rulesString, attributes: attributes)
        
        resetButton.titleLabel?.font = UIFont(name: "NYTFranklin-Medium", size: 14)
        resetButton.setTitle("Reset Puzzle", for: .normal)
        resetButton.layer.borderColor = UIColor(red: 0.863, green: 0.863, blue: 0.863, alpha: 1).cgColor
        resetButton.layer.borderWidth = 1
        resetButton.layer.cornerRadius = 23
        if (first ?? false) {
            resetButton.setTitle("Continue", for: .normal)
        }
    }
    
    func setDelegate(_ del: RulesViewControllerDelegate, isFirst: Bool? = false) {
        delegate = del
        if (isFirst!) {
            first = true
        }
    }

    @IBAction func closeRulesPopUp(_ sender: Any) {
        self.removeAnimate()
    }
   
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3) //make view bigger at first
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0) //then scale view back down
        })
    }
   
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
           }, completion:{(finished : Bool)  in
               if (finished) {
                    self.resetButton.setTitle("Reset Puzzle", for: .normal)
                    self.view.removeFromSuperview()

                self.delegate!.closed()
               }
        })
    }
    
    @IBAction func resetButton(_ sender: Any) {
        delegate!.resetPuzzle()
        self.removeAnimate()
    }
    
}

//
//  ClockViewController.swift
//  Prototype
//
//  Copyright © 2020 2020 Interns. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController {

    @IBOutlet weak var clockView: ClockView!
    @IBOutlet weak var numbersView: NumbersView!
    @IBOutlet weak var youWin: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numbersView.setDelegate(del: self)
        self.view.backgroundColor = UIColor(red: 0.99, green: 0.47, blue: 0.33, alpha: 1.00)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        clockView.setRadius()
        numbersView.setFrame()
    }
    
    @IBAction func onRestart(_ sender: Any) {
        numbersView.restart()
        UIView.animate(withDuration:0.3, animations: {
            self.youWin.alpha = 0
            self.restartButton.alpha = 0
        })
        
    }
}



extension ClockViewController: NumbersViewDelegate {
    func whenFinished() {
        UIView.animate(withDuration:0.3, animations: {
            self.youWin.alpha = 1.0
            self.restartButton.alpha = 1.0
        })
    }
    func showLinesForNumber(number: String) {
        clockView.showLines(number)
    }
    func hideLines() {
        clockView.hideLines()
    }
}

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numbersView.setDelegate(del: self)
        self.view.backgroundColor = UIColor(red: 0.99, green: 0.47, blue: 0.33, alpha: 1.00)
    }
}

extension ClockViewController: NumbersViewDelegate {
    func whenFinished() {
        youWin.isHidden=false
    }
    func showLinesForNumber(number: String) {
        clockView.showLines(number)
    }
    func hideLines() {
        clockView.hideLines()
    }
}

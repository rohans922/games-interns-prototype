//
//  ClockViewController.swift
//  Prototype
//
//  Copyright © 2020 2020 Interns. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onNextButton(_ sender: Any) {
        nextTurn();
    }

    @IBAction func onSwapButton(_ sender: Any) {
        print("Swapping Values")
        nextTurn();
    }
    
    private func nextTurn() {
        print("Next Turn")
    }
}

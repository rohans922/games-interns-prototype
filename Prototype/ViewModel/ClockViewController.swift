//
//  ClockViewController.swift
//  Prototype
//


import UIKit

class ClockViewController: UIViewController, ClockViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let clock = ClockView(frame: CGRect.zero)
        self.view.addSubview(clock)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

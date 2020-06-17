//  ClockView.swift
//  Prototype

import UIKit

protocol ClockViewDelegate {
    
}

class ClockView: UIView {
    @IBOutlet weak var clockImage: UIImageView!
    
    override func draw(_ rect: CGRect) {
        let p = UIBezierPath(ovalIn: CGRect(x:0,y:0,width:100,height:100))
        UIColor.blue.setFill()
        p.fill()
    }
}

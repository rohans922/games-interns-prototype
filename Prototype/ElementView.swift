//
//  Element.swift
//  Prototype
//
//  Created by Rohan Shaiva on 6/23/20.
//  Copyright © 2020 2020 Interns. All rights reserved.
//

import UIKit

class ElementView: UIView {

    @IBOutlet var elementView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var highlight: UIView!
    private var location: CGPoint?
    private var imageName: String?
    private var index: Int?
    private var animationIndex: Int?
    private var symbol: String?
    private var swapIndices: [Int] = []
    private var isError: Bool?
    private var notificationFeedbackGenerator: UINotificationFeedbackGenerator?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ElementView", owner: self, options: nil)
        addSubview(elementView)
        elementView.frame = self.bounds
        isError = false
        notificationFeedbackGenerator = UINotificationFeedbackGenerator()
        notificationFeedbackGenerator!.prepare()
    }
    
    func setSwapIndices(_ first: Int, _ second: Int) {
        swapIndices.append(first)
        swapIndices.append(second)
    }
    
    func getSwapIndices() -> [Int] {
        return swapIndices
    }
    
    func setIndex(i: Int) {
        index = i
        animationIndex = index
    }
    
    func getIndex() -> Int {
        return index!
    }
    
    func setImageName(image: String, symbolName: String? = nil) {
        if (symbolName != nil) {
            symbol = symbolName
        }
        imageName = image
        imageView.image = UIImage(named: image)
    }
    
    func getImageName() -> String {
        return imageName!
    }
    
    func setLocation(point: CGPoint) {
        location = point
    }
    
    func getLocation() -> CGPoint {
        return location!
    }
    func iterateImage() {
        animationIndex! = (animationIndex! + 1) % 8
        imageView.image = UIImage(named: (String(animationIndex! + 1)) + "_" + symbol!)
    }
    
    func setQuickHighlight() {
        
    }
    
    func setMoveableHighlight() {
        highlight.layer.cornerRadius = highlight.frame.height / 2
        highlight.backgroundColor = UIColor(red: 0.271, green: 0.239, blue: 0.202, alpha: 0.3)
        UIView.animate(withDuration:0.2, animations: {
            self.highlight.alpha = 1
        })
    }
    
    func getIsError() -> Bool {
        return isError!
    }
    
    func isNotError() {
        isError = false
    }
    
    func setErrorHighlight() {
        if (!isError!) {
            notificationFeedbackGenerator!.notificationOccurred(.error)
        }
        isError = true
        UIView.animate(withDuration:0.1, animations: {
            self.elementView.transform = CGAffineTransform(translationX: 5, y: 0)
        }, completion: {(value: Bool) in
            UIView.animate(withDuration: 0.1, animations: {
                self.elementView.transform = CGAffineTransform(translationX: -5, y: 0)
            }, completion: {(value: Bool) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.elementView.transform = .identity
                })
            })
        })
    }
    
    func setMovingHighlight() {
        highlight.layer.cornerRadius = highlight.frame.height / 2
        highlight.backgroundColor = UIColor(red: 0.2, green: 0.4, blue: 0.6275, alpha: 0.8)
        UIView.animate(withDuration:0.1, animations: {
            self.highlight.alpha = 1
        })
    }

    func resetHighlight() {
        UIView.animate(withDuration:0.3, animations: {
            self.highlight.alpha = 0
        })
    }

}

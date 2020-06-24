//
//  NumbersView.swift
//  Prototype
//
//  Copyright © 2020 2020 Interns. All rights reserved.
//

import UIKit

protocol NumbersViewDelegate {
    func showLinesForNumber(number: String)
    func hideLines()
    func whenFinished()
}

class NumbersView: UIView {
    
    private var delegate: NumbersViewDelegate?
    private var gameOver: Bool?
    @IBOutlet var numbersView: UIView!
    @IBOutlet var elementViews: [ElementView]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        gameOver = false
        Bundle.main.loadNibNamed("NumbersView", owner: self, options: nil)
        addSubview(numbersView)
        numbersView.frame = self.bounds
        numbersView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        let sequence = 0 ..< 8 // Comment out if not random order
//        let shuffledSequence = sequence.shuffled() // Use for random order
//        let shuffledSequence = [7, 1, 6, 0, 5, 3, 2, 4] // Use for not random order
        let shuffledSequence = [0, 1, 2, 3, 4, 5, 6, 7] // Use for correct order
        for (index, element) in elementViews.enumerated() {
            element.setIndex(i: index)
            element.setImageName(image: String(shuffledSequence[index] + 1) + "_chick" )
            element.setSwapIndices((index + 3) % 8, (index + 5) % 8)
        }
        
        let oneGR = UIPanGestureRecognizer.init(target: self, action: #selector(handleOne(recognizer:)))
        elementViews[0].addGestureRecognizer(oneGR)
        let twoGR = UIPanGestureRecognizer.init(target: self, action: #selector(handleTwo(recognizer:)))
        elementViews[1].addGestureRecognizer(twoGR)
        let threeGR = UIPanGestureRecognizer.init(target: self, action: #selector(handleThree(recognizer:)))
        elementViews[2].addGestureRecognizer(threeGR)
        let fourGR = UIPanGestureRecognizer.init(target: self, action: #selector(handleFour(recognizer:)))
        elementViews[3].addGestureRecognizer(fourGR)
        let fiveGR = UIPanGestureRecognizer.init(target: self, action: #selector(handleFive(recognizer:)))
        elementViews[4].addGestureRecognizer(fiveGR)
        let sixGR = UIPanGestureRecognizer.init(target: self, action: #selector(handleSix(recognizer:)))
        elementViews[5].addGestureRecognizer(sixGR)
        let sevenGR = UIPanGestureRecognizer.init(target: self, action: #selector(handleSeven(recognizer:)))
        elementViews[6].addGestureRecognizer(sevenGR)
        let eightGR = UIPanGestureRecognizer.init(target: self, action: #selector(handleEight(recognizer:)))
        elementViews[7].addGestureRecognizer(eightGR)
    }
    
    func setFrame() {
        numbersView.frame = self.bounds
        for e in elementViews {
            e.setLocation(point: e.center)
        }
    }
    
    func setDelegate(del: NumbersViewDelegate) {
        delegate = del
    }
    
    @objc func handleOne(recognizer: UIPanGestureRecognizer) {
        if (!gameOver!) {
            handlePan(recognizer)
        }
    }
    @objc func handleTwo(recognizer: UIPanGestureRecognizer) {
        if (!gameOver!) {
            handlePan(recognizer)
        }
    }
    @objc func handleThree(recognizer: UIPanGestureRecognizer) {
        if (!gameOver!) {
            handlePan(recognizer)
        }
    }
    @objc func handleFour(recognizer: UIPanGestureRecognizer) {
        if (!gameOver!) {
            handlePan(recognizer)
        }
    }
    @objc func handleFive(recognizer: UIPanGestureRecognizer) {
        if (!gameOver!) {
            handlePan(recognizer)
        }
    }
    @objc func handleSix(recognizer: UIPanGestureRecognizer) {
        if (!gameOver!) {
            handlePan(recognizer)
        }
    }
    @objc func handleSeven(recognizer: UIPanGestureRecognizer) {
        if (!gameOver!) {
            handlePan(recognizer)
        }
    }
    @objc func handleEight(recognizer: UIPanGestureRecognizer) {
        if (!gameOver!) {
            handlePan(recognizer)
        }
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.numbersView)
        if let view = recognizer.view as? ElementView {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
            let swapIndices = view.getSwapIndices()
            let hitbox = view.frame.insetBy(dx: 25, dy: 10)
            if hitbox.intersects(elementViews[swapIndices[0]].frame) {
                recognizer.state = .ended
                let swap = view.getImageName()
                view.setImageName(image: elementViews[swapIndices[0]].getImageName())
                elementViews[swapIndices[0]].setImageName(image: swap)
            } else if hitbox.intersects(elementViews[swapIndices[1]].frame) {
                recognizer.state = .ended
                let swap = view.getImageName()
                view.setImageName(image: elementViews[swapIndices[1]].getImageName())
                elementViews[swapIndices[1]].setImageName(image: swap)
            }
        }
        recognizer.setTranslation(CGPoint.zero, in: self.numbersView)
        if recognizer.state == .began {
            if let view = recognizer.view as? ElementView {
                let swapIndices = view.getSwapIndices()
                let draggedIndex = view.getIndex()
                delegate?.showLinesForNumber(number: String(draggedIndex + 1))
                UIView.animate(withDuration:0.3, animations: {
                    for (index, element) in self.elementViews.enumerated() {
                        if ((!swapIndices.contains(index)) && index != draggedIndex) {
                            element.alpha = 0.5
                        }
                    }
                })
            }
        }
        if recognizer.state == .ended {
            delegate?.hideLines()
            var counter = 0
            for (index, element) in elementViews.enumerated() {
                if (element.getImageName() == String(index + 1) + "_chick") {
                    counter += 1
                }
            }
            if (counter == 8) {
                gameOver = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    UIView.animate(withDuration:1.0, animations: {
                        for a in self.elementViews {
                            a.center = CGPoint(x: self.numbersView.center.x, y: self.numbersView.center.y)
                            a.transform = CGAffineTransform(scaleX: 2, y: 2)
                        }
                    })
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        DispatchQueue.global(qos: .default).async {
                            while(true) {
                                for (index, element) in self.elementViews.enumerated() {
                                     DispatchQueue.main.async {
                                        for (index2, element2) in self.elementViews.enumerated() {
                                            if index2 != index {
                                                element2.isHidden = true
                                            }
                                        }
                                        element.isHidden = false
                                     }

                                    usleep(80000)

                                }
                            }
                        }
                    }
                }
                delegate?.whenFinished()
            }
            UIView.animate(withDuration:0.3, animations: {
                for a in self.elementViews {
                    a.alpha = 1
                }
            })
            if let view = recognizer.view as? ElementView {
                UIView.animate(withDuration:0.5, animations: {
                    view.center = view.getLocation()
                })
            }
        }
    }
}

    
    
    




    


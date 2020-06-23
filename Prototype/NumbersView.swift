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
}

class NumbersView: UIView {
    
    private var delegate: NumbersViewDelegate?
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
        Bundle.main.loadNibNamed("NumbersView", owner: self, options: nil)
        addSubview(numbersView)
        numbersView.frame = self.bounds
        numbersView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        for (index, element) in elementViews.enumerated() {
            element.setIndex(i: index)
            element.setImageName(image: String(index + 1))
            element.setLocation(point: element.center)
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
    
    func setDelegate(del: NumbersViewDelegate) {
        delegate = del
    }
    
    @objc func handleOne(recognizer: UIPanGestureRecognizer) {
        handlePan(recognizer)
    }
    @objc func handleTwo(recognizer: UIPanGestureRecognizer) {
        handlePan(recognizer)
    }
    @objc func handleThree(recognizer: UIPanGestureRecognizer) {
        handlePan(recognizer)
    }
    @objc func handleFour(recognizer: UIPanGestureRecognizer) {
        handlePan(recognizer)
    }
    @objc func handleFive(recognizer: UIPanGestureRecognizer) {
        handlePan(recognizer)
    }
    @objc func handleSix(recognizer: UIPanGestureRecognizer) {
        handlePan(recognizer)
    }
    @objc func handleSeven(recognizer: UIPanGestureRecognizer) {
        handlePan(recognizer)
    }
    @objc func handleEight(recognizer: UIPanGestureRecognizer) {
        handlePan(recognizer)
    }
    
    private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.numbersView)
        if let view = recognizer.view as? ElementView {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
            let swapIndices = view.getSwapIndices()
            if view.frame.intersects(elementViews[swapIndices[0]].frame) {
                recognizer.state = .ended
                let swap = view.getImageName()
                view.setImageName(image: elementViews[swapIndices[0]].getImageName())
                elementViews[swapIndices[0]].setImageName(image: swap)
            } else if view.frame.intersects(elementViews[swapIndices[1]].frame) {
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

    
    
    




    


//
//  NumbersView.swift
//  Prototype
//
//  Copyright © 2020 2020 Interns. All rights reserved.
//

import UIKit

protocol NumbersViewDelegate {
    func whenFinished()
    func animateSequence(elementViews: [ElementView])
    func setAnimationImage(image: String)
}

class NumbersView: UIView {
    
    private var delegate: NumbersViewDelegate?
    private var gameOver: Bool?
    private var animationCount: Int?
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
        setupProject()
        for a in elementViews {
            let GR = UIPanGestureRecognizer.init(target: self, action: #selector(handleAllGR(recognizer:)))
            a.addGestureRecognizer(GR)
        }
        animationCount = 0
    }
    
    func setupProject() {
        gameOver = false
//            let sequence = 0 ..< 8 // Comment out if not random order
//            let shuffledSequence = sequence.shuffled() // Use for random order
        
//        let shuffledSequence = [7, 1, 6, 0, 5, 3, 2, 4] // Use for not random order
        let shuffledSequence = [0, 4, 2, 3, 1, 5, 6, 7] // Use for slightly correct order
//        let shuffledSequence = [0, 1, 2, 3, 4, 5, 6, 7] // Use for correct order
        for (index, element) in elementViews.enumerated() {
            element.setIndex(i: index)
            element.setImageName(image: String(shuffledSequence[index] + 1) + "_chick", symbolName: "chick")
            element.setSwapIndices((index + 3) % 8, (index + 5) % 8)
        }
    }
    
    func restart () {
        gameOver = false
        self.animationCount! = 1001
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration:0.5, animations: {
                for a in self.elementViews {
                    a.center = a.getLocation()
                    a.alpha = 1
                    a.transform = .identity
                }
            })
            self.setupProject()
        }
    }
    
    func setFrame() {
        numbersView.frame = self.bounds
        for e in elementViews {
            e.setLocation(point: e.center)
        }
    }
    
    func setDelegate(del: NumbersViewDelegate) {
        delegate = del
        delegate?.setAnimationImage(image: elementViews[7].getImageName())
    }
    
    @objc func handleAllGR(recognizer: UIPanGestureRecognizer) {
        if (!gameOver!) {
            handlePan(recognizer)
        }
    }
    
    func startAnimation() {
        if (!gameOver!) {
            delegate?.animateSequence(elementViews: elementViews)
        }
    }
    
    private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.numbersView)
        if let view = recognizer.view as? ElementView {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
            let swapIndices = view.getSwapIndices()
            let hitbox = view.frame
            if hitbox.intersects(elementViews[swapIndices[0]].frame) {
                recognizer.state = .ended
                let swap = view.getImageName()
                view.setImageName(image: elementViews[swapIndices[0]].getImageName())
                elementViews[swapIndices[0]].setImageName(image: swap)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.startAnimation()
                }
            } else if hitbox.intersects(elementViews[swapIndices[1]].frame) {
                recognizer.state = .ended
                let swap = view.getImageName()
                view.setImageName(image: elementViews[swapIndices[1]].getImageName())
                elementViews[swapIndices[1]].setImageName(image: swap)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    if (!self.gameOver!) {
                        self.delegate?.animateSequence(elementViews: self.elementViews)
                    }
                }
            }
        }
        
        recognizer.setTranslation(CGPoint.zero, in: self.numbersView)
        if recognizer.state == .began {
            if let view = recognizer.view as? ElementView {
                let swapIndices = view.getSwapIndices()
                let draggedIndex = view.getIndex()
                view.setMovingHighlight()
                for a in swapIndices {
                    elementViews[a].setMoveableHighlight()
                }
                UIView.animate(withDuration:0.3, animations: {
                    for (index, element) in self.elementViews.enumerated() {
                        if ((!swapIndices.contains(index)) && index != draggedIndex) {
                            element.alpha = 0.4
                        }
                    }
                })
            }
        }
        if recognizer.state == .ended {
            var counter = 0
            for (index, element) in elementViews.enumerated() {
                element.resetHighlight()
                if (element.getImageName() == String(index + 1) + "_chick") {
                    counter += 1
                }
            }
            if (counter == 8) {
                gameOver = true
                numbersView.bringSubviewToFront(elementViews[0])
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    for a in self.elementViews {
                        a.iterateImage()
                    }
                    
                    var _ = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true){ t in
                        self.animationCount! += 1
                        for a in self.elementViews {
                            a.iterateImage()
                        }
                        if self.animationCount! >= 1 {
                            t.invalidate()
                            self.animationCount! = 0
                            var _ = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true){ t in
                                self.animationCount! += 1
                                for a in self.elementViews {
                                    a.iterateImage()
                                }
                                if self.animationCount! >= 2 {
                                    t.invalidate()
                                    self.animationCount! = 0
                                    var _ = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true){ t in
                                        self.animationCount! += 1
                                        for a in self.elementViews {
                                            a.iterateImage()
                                        }
                                        if self.animationCount! >= 3 {
                                            t.invalidate()
                                            self.delegate?.whenFinished()
                                            self.animationCount! = 0
                                            var _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){ t in
                                                self.animationCount! += 1
                                                for a in self.elementViews {
                                                    a.iterateImage()
                                                }
                                                if self.animationCount! >= 1000 {
                                                    t.invalidate()
                                                }
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                    UIView.animate(withDuration:0.6, delay: 2.5, options: .curveEaseOut, animations: {
                        for (index, element) in self.elementViews.enumerated() {
                            if (index != 0) {
                                element.alpha = 0
                            }
                        }
                    })
                    UIView.animate(withDuration:0.6, delay: 3.5, options: .curveEaseInOut, animations: {
                        self.elementViews[0].transform = CGAffineTransform(scaleX: 3, y: 3)
                        self.elementViews[0].center = CGPoint(x:                         self.elementViews[0].center.x, y: self.elementViews[0].center.y - (self.numbersView.superview!.frame.height / 3))
                    })
                }
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

    
    
    




    


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
    func whenAnimatingEnd()
}

class NumbersView: UIView {
    private var currentSequence: [Int]?
    private var delegate: NumbersViewDelegate?
    private var gameOver: Bool?
    private var animationCount: Int?
    private var animationDeltaY: CGFloat?
    private var frameWidth: CGFloat?
    private var currentSymbol: String?
    private var selectionFeedbackGenerator: UISelectionFeedbackGenerator?
    private var notificationFeedbackGenerator: UINotificationFeedbackGenerator?
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
        selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        notificationFeedbackGenerator = UINotificationFeedbackGenerator()
        notificationFeedbackGenerator!.prepare()
        numbersView.frame = self.bounds
        numbersView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setupProject()
        for (index, element) in elementViews.enumerated() {
            let GR = UIPanGestureRecognizer.init(target: self, action: #selector(handleAllGR(recognizer:)))
            element.addGestureRecognizer(GR)
            if (index != 0) {
                element.alpha = 0
            }
        }
        animationCount = 0
    }
    
    func setupProject(symbol: String? = "chick") {
        currentSymbol = symbol
        gameOver = false
//        let sequence = 0 ..< 8 // Comment out if not random order
//        let shuffledSequence = sequence.shuffled() // Use for random order
//        let shuffledSequence = [7, 1, 6, 0, 5, 3, 2, 4] // Use for not random order
        let shuffledSequence = [0, 1, 7, 3, 4, 5, 6, 2] // Use for slightly correct order
//        let shuffledSequence = [0, 1, 2, 3, 4, 5, 6, 7] // Use for correct order
        currentSequence = shuffledSequence
        for (index, element) in elementViews.enumerated() {
            element.setIndex(i: index)
            element.setImageName(image: String(shuffledSequence[index] + 1) + "_" + currentSymbol!, symbolName: currentSymbol!)
            element.setSwapIndices((index + 3) % 8, (index + 5) % 8)
        }
    }
    
    func retry () {
        for (index, element) in elementViews.enumerated() {
            element.setImageName(image: String(currentSequence![index] + 1) + "_" + currentSymbol!, symbolName: currentSymbol!)
        }
    }
    
    func restart (symbol: String) {
        gameOver = false
        self.animationCount! = 2001
        UIView.animate(withDuration:0.5, delay: 2.2, animations: {
            for a in self.elementViews {
                a.center = a.getLocation()
                a.alpha = 1
                a.transform = .identity
            }
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.setupProject(symbol: symbol)
        }
    }
    
    func getLast () -> String {
        return (String(currentSequence![7] + 1) + "_" + currentSymbol!)
    }
    
    func setFrame(numbersCenter: CGPoint, animationCenter: CGPoint) {
        numbersView.frame = self.bounds
        for e in elementViews {
            e.setLocation(point: e.center)
        }
        animationDeltaY = (numbersCenter.y - (numbersView.center.y - elementViews[0].center.y)) - animationCenter.y
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.elementViews[0].transform = CGAffineTransform(scaleX: 3, y: 3)
            self.elementViews[0].center = CGPoint(x:                         self.elementViews[0].center.x, y: self.elementViews[0].center.y - self.animationDeltaY!)
        }
        UIView.animate(withDuration:0.3, delay: 1.7, animations: {
            for e in self.elementViews {
                    e.alpha = 1
            }
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            UIView.animate(withDuration:0.3, delay: 0, animations: {
                self.elementViews[0].center = self.elementViews[0].getLocation()
                self.elementViews[0].transform = .identity
            })
        }
        frameWidth = numbersView.frame.width / 2
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

    func calculateDistance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return CGFloat(sqrt(xDist * xDist + yDist * yDist))
    }
    
    private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.numbersView)
        if let view = recognizer.view as? ElementView {
            if (calculateDistance(numbersView.center, view.center) <= frameWidth!) {
                view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
                let swapIndices = view.getSwapIndices()
                let hitbox = view.frame.insetBy(dx: 10, dy: 10)
                if hitbox.intersects(elementViews[swapIndices[0]].frame) {
                    notificationFeedbackGenerator!.notificationOccurred(.success)
                    recognizer.state = .ended
                    let swap = view.getImageName()
                    view.setImageName(image: elementViews[swapIndices[0]].getImageName())
                    elementViews[swapIndices[0]].setImageName(image: swap)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.startAnimation()
                    }
                } else if hitbox.intersects(elementViews[swapIndices[1]].frame) {
                    notificationFeedbackGenerator!.notificationOccurred(.success)
                    recognizer.state = .ended
                    let swap = view.getImageName()
                    view.setImageName(image: elementViews[swapIndices[1]].getImageName())
                    elementViews[swapIndices[1]].setImageName(image: swap)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        if (!self.gameOver!) {
                            self.delegate?.animateSequence(elementViews: self.elementViews)
                        }
                    }
                } else {
                    for (index, element) in elementViews.enumerated() {
                        if (index != view.getIndex()) && (!element.getIsError()) && (hitbox.intersects(element.frame)) {
                            element.setErrorHighlight()
                        } else if (!hitbox.intersects(element.frame)) && (element.getIndex() != swapIndices[0]) && (element.getIndex() != swapIndices[1]) {
                            element.isNotError()
                            element.resetHighlight()
                        }
                    }
                }
            } else {
                recognizer.state = .ended
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
                if (element.getImageName() == String(index + 1) + "_" + currentSymbol!) {
                    counter += 1
                }
            }
            if (counter == 8) {
                gameOver = true
                delegate?.whenAnimatingEnd()
                numbersView.bringSubviewToFront(elementViews[0])
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    for a in self.elementViews {
                        a.iterateImage()
                    }
                    self.selectionFeedbackGenerator!.selectionChanged()
                    var _ = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true){ t in
                        self.animationCount! += 1
                        for a in self.elementViews {
                            a.iterateImage()
                        }
                        self.selectionFeedbackGenerator!.selectionChanged()
                        if self.animationCount! >= 1 {
                            t.invalidate()
                            self.animationCount! = 0
                            var _ = Timer.scheduledTimer(withTimeInterval: 0.18, repeats: true){ t in
                                self.animationCount! += 1
                                for a in self.elementViews {
                                    a.iterateImage()
                                }
                                self.selectionFeedbackGenerator!.selectionChanged()
                                if self.animationCount! >= 2 {
                                    t.invalidate()
                                    self.animationCount! = 0
                                    var _ = Timer.scheduledTimer(withTimeInterval: 0.13, repeats: true){ t in
                                        self.animationCount! += 1
                                        for a in self.elementViews {
                                            a.iterateImage()
                                        }
                                        self.selectionFeedbackGenerator!.selectionChanged()
                                        if self.animationCount! >= 1 {
                                            t.invalidate()
                                            self.delegate?.whenFinished()
                                            self.animationCount! = 0
                                            var _ = Timer.scheduledTimer(withTimeInterval: 0.11, repeats: true){ t in
                                                self.animationCount! += 1
                                                for a in self.elementViews {
                                                    a.iterateImage()
                                                }
                                                if self.animationCount! <= 9 {
                                                    self.selectionFeedbackGenerator!.selectionChanged()
                                                }
                                                if self.animationCount! >= 2000 {
                                                    t.invalidate()
                                                }
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                    UIView.animate(withDuration:0.6, delay: 1.2, options: .curveEaseOut, animations: {
                        for (index, element) in self.elementViews.enumerated() {
                            if (index != 0) {
                                element.alpha = 0
                            }
                        }
                    })
                    UIView.animate(withDuration:0.6, delay: 1.4, options: .curveEaseInOut, animations: {
                        self.elementViews[0].transform = CGAffineTransform(scaleX: 3, y: 3)
                        self.elementViews[0].center = CGPoint(x:                         self.elementViews[0].center.x, y: self.elementViews[0].center.y - self.animationDeltaY!)
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

    
    
    




    


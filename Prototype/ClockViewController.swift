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
    @IBOutlet weak var finalAnimationView: UIImageView!
    @IBOutlet weak var youWin: UILabel!
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var animationImage: UIImageView!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var animationSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numbersView.setDelegate(del: self)
        self.view.backgroundColor = UIColor(red: 0.99, green: 0.47, blue: 0.33, alpha: 1.00)
        animationSwitch!.onTintColor = UIColor(red: 0, green: 0.2941, blue: 0.5373, alpha: 1.0)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        clockView.setRadius()
        numbersView.setFrame()
    }
    
    @IBAction func onRestart(_ sender: Any) {
        numbersView.restart()
        animationSwitch.setOn(false, animated: true)
        UIView.animate(withDuration:0.3, animations: {
            self.youWin.alpha = 0
            self.restartButton.alpha = 0
            self.clockView.alpha = 1
            self.arrow.alpha = 1
            self.numbersView.alpha = 1
            self.finalAnimationView.alpha = 0
            self.finalAnimationView.stopAnimating()
        })
        
    }
    @IBAction func onSwitch(_ sender: Any) {
        if animationSwitch.isOn {
            numbersView.startAnimation()
        } else {
            UIView.animate(withDuration:0.1, delay: 0, animations: {
                self.animationImage.alpha = 0.0
                self.animationImage.stopAnimating()
            })
        }
    }
}

extension ClockViewController: NumbersViewDelegate {
    func whenFinished() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animationImage.stopAnimating()
            UIView.animate(withDuration:0.1, delay: 0, animations: {
                self.animationImage.alpha = 0.0
            })
            var animationImages: [UIImage] = []
            for n in 1...8 {
                animationImages.append(UIImage(named: String(n) + "_chick")!)
            }
            self.finalAnimationView.image = animationImages[0]
            self.finalAnimationView.animationImages = animationImages
            self.finalAnimationView.animationDuration = 0.8
            self.finalAnimationView.animationRepeatCount = 1000
            
            UIView.animate(withDuration:0.3, animations: {
                self.arrow.alpha = 0
            })
            UIView.animate(withDuration: 0.3, delay: 0.5, animations: {
                self.clockView.alpha = 0.0
            }, completion: {[weak self] finished in
                UIView.animate(withDuration: 0.3, delay: 0.15, animations: {
                    self?.numbersView.alpha = 0.0
                })
                UIView.animate(withDuration: 0.2, delay: 0.1, animations: {
                    self?.finalAnimationView.alpha = 1.0
                }, completion: {[weak self] finished in
                    self?.finalAnimationView.startAnimating()
                })
                UIView.animate(withDuration: 0.3, delay: 0.2, animations: {
                    self?.youWin.alpha = 1.0
                    self?.restartButton.alpha = 1.0
                })
                }
            )
        }
    }
    func showLinesForNumber(number: String) {
        clockView.showLines(number)
    }
    func hideLines() {
        clockView.hideLines()
    }
    func animateSequence(elementViews: [ElementView]) {
        if (animationSwitch.isOn) {
            self.animationImage.stopAnimating()
            var animationImages: [UIImage] = []
            for a in elementViews {
                animationImages.append(UIImage(named: a.getImageName())!)
            }
            animationImage.image = animationImages[0]
            animationImage.animationImages = animationImages
            animationImage.animationDuration = 0.8
            animationImage.animationRepeatCount = 1000
    //        make value 1 if just one loop is desired
            
            UIView.animate(withDuration:0.1, animations: {
                self.animationImage.alpha = 1.0
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.animationImage.startAnimating()
            }
        }
    }
}

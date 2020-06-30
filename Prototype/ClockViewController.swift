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
    @IBOutlet weak var winMessage: UILabel!
    @IBOutlet weak var camera: UIImageView!
    @IBOutlet weak var animationImage: UIImageView!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var blackShadow: UIView!
    @IBOutlet weak var grayShadow: UIView!
    @IBOutlet weak var filmStrip: UIImageView!
    @IBOutlet weak var roundArrow: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numbersView.setDelegate(del: self)
        self.view.backgroundColor = UIColor(red: 0.373, green: 0.514, blue: 0.651, alpha: 1)
        blackShadow.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        grayShadow.backgroundColor = UIColor(red: 0.27, green: 0.368, blue: 0.467, alpha: 1)
//        animationSwitch!.onTintColor = UIColor(red: 0, green: 0.2941, blue: 0.5373, alpha: 1.0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view == animationImage {
            numbersView.startAnimation()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        clockView.setRadius()
        numbersView.setFrame()
        header.layer.borderColor = UIColor.black.cgColor
        header.layer.borderWidth = 1
        blackShadow.layer.cornerRadius = blackShadow.frame.height / 2
        grayShadow.layer.cornerRadius = blackShadow.frame.height / 2
    }
    
    @IBAction func onHelp(_ sender: Any) {
        print("HELP BUTTON PRESSED")
    }
    
    @IBAction func onRestart(_ sender: Any) {
        numbersView.restart()
//        animationSwitch.setOn(false, animated: true)
        UIView.animate(withDuration:0.3, animations: {
            self.youWin.alpha = 0
            self.winMessage.alpha = 0
            self.nextButton.alpha = 0
            self.restartButton.alpha = 0
            self.clockView.alpha = 1
            self.camera.alpha = 1
            self.roundArrow.alpha = 1
            self.filmStrip.alpha = 1
            self.blackShadow.alpha = 1
            self.grayShadow.alpha = 1
        })
        UIView.animate(withDuration:0.3, delay: 0.9, animations: {
            self.animationImage.alpha = 1
        })
        
    }
}

extension ClockViewController: NumbersViewDelegate {
    func setAnimationImage(image: String) {
        animationImage.image = UIImage(named: image)
    }
    
    func whenFinished() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.animationImage.stopAnimating()
            UIView.animate(withDuration:0.1, delay: 0, animations: {
                self.animationImage.alpha = 0.0
            })
            var animationImages: [UIImage] = []
            for n in 1...8 {
                animationImages.append(UIImage(named: String(n) + "_chick")!)
            }
            
            UIView.animate(withDuration:0.3, animations: {
                self.camera.alpha = 0
                self.roundArrow.alpha = 0
            })
            UIView.animate(withDuration: 0.3, delay: 0.5, animations: {
                self.clockView.alpha = 0.0
                self.filmStrip.alpha = 0
                self.blackShadow.alpha = 0
                self.grayShadow.alpha = 0
                
            }, completion: {[weak self] finished in
                UIView.animate(withDuration: 0.3, delay: 0.4, animations: {
                    self?.youWin.alpha = 1.0
                })
                UIView.animate(withDuration: 0.3, delay: 0.5, animations: {
                    self?.winMessage.alpha = 1.0
                })
                UIView.animate(withDuration: 0.3, delay: 0.6, animations: {
                    self?.restartButton.alpha = 1.0
                    self?.nextButton.alpha = 1.0
                })
                }
            )
        }
    }
    
    func animateSequence(elementViews: [ElementView]) {
            self.animationImage.stopAnimating()
            var animationImages: [UIImage] = []
            for a in elementViews {
                animationImages.append(UIImage(named: a.getImageName())!)
            }
            animationImage.image = animationImages[7]
            animationImage.animationImages = animationImages
            animationImage.animationDuration = 2.5
            animationImage.animationRepeatCount = 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.animationImage.startAnimating()
            }
//        }
    }
}

//
//  ClockViewController.swift
//  Prototype
//
//  Copyright © 2020 2020 Interns. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController {

    private let symbolSequence: [String] = ["chick", "match"]
    private var currentSymbolIndex: Int?
    private var firstOpen: Bool?
    
    @IBOutlet weak var clockView: ClockView!
    @IBOutlet weak var numbersView: NumbersView!
    @IBOutlet weak var youWin: UILabel!
    @IBOutlet weak var winMessage: UILabel!
    @IBOutlet weak var levelName: UILabel!
    @IBOutlet weak var camera: UIImageView!
    @IBOutlet weak var animationImage: UIImageView!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var blackShadow: UIView!
    @IBOutlet weak var grayShadow: UIView!
    @IBOutlet weak var filmBackground: UIImageView!
    @IBOutlet weak var dialogue: UIView!
    @IBOutlet weak var dialogueLabel: UILabel!
    @IBOutlet weak var filmStrip: UIImageView!
    @IBOutlet weak var roundArrow: UIImageView!
    @IBOutlet weak var finalAnimationLocation: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        firstOpen = true
        clockView.alpha = 0
        camera.alpha = 0
        roundArrow.alpha = 0
        filmStrip.alpha = 0
        blackShadow.alpha = 0
        grayShadow.alpha = 0
        header.alpha = 0
        animationImage.alpha = 0
        filmBackground.alpha = 0
        titleLabel.font = UIFont(name: "NYTKarnakCondensed-Bold", size: 30)
        youWin.font = UIFont(name: "NYTKarnakCondensed-Bold", size: 38)
        levelName.font = UIFont(name: "NYTKarnakCondensed-Bold", size: 40)
        winMessage.font = UIFont(name: "NYTFranklin-Medium", size: 18)
        dialogueLabel.font = UIFont(name: "NYTFranklin-Medium", size: 17)
        restartButton.titleLabel?.font = UIFont(name: "NYTFranklin-Medium", size: 14)
        nextButton.titleLabel?.font = UIFont(name: "NYTFranklin-Medium", size: 14)
        restartButton.layer.borderColor = UIColor(red: 0.863, green: 0.863, blue: 0.863, alpha: 1).cgColor
        nextButton.layer.borderColor = UIColor(red: 0.863, green: 0.863, blue: 0.863, alpha: 1).cgColor
        restartButton.layer.borderWidth = 1
        nextButton.layer.borderWidth = 1
        blackShadow.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        grayShadow.backgroundColor = UIColor(red: 0.27, green: 0.368, blue: 0.467, alpha: 1)
        numbersView.setDelegate(del: self)
        currentSymbolIndex = 0
        levelName.text = symbolSequence[currentSymbolIndex!].prefix(1).capitalized + symbolSequence[currentSymbolIndex!].dropFirst()
        
        UIView.animate(withDuration:0.5, delay: 0.2, animations: {
            self.levelName.alpha = 1
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            UIView.animate(withDuration:0.3, animations: {
               self.levelName.alpha = 0
               self.clockView.alpha = 1
               self.camera.alpha = 1
               self.roundArrow.alpha = 1
               self.filmStrip.alpha = 1
               self.blackShadow.alpha = 1
               self.grayShadow.alpha = 1
               self.header.alpha = 1
               self.view.backgroundColor = UIColor(red: 0.373, green: 0.514, blue: 0.651, alpha: 1)
           })
            UIView.animate(withDuration:0.3, delay: 0.9, animations: {
                self.animationImage.alpha = 1
                self.filmBackground.alpha = 1
            })
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            UIView.animate(withDuration:0.3, animations: {
                self.dialogue.alpha = 1
            }, completion: {(value: Bool) in
                UIView.animate(withDuration:0.3, delay: 4.5, animations: {
                    self.dialogue.alpha = 0
                })
            })
        }
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
        if (firstOpen!) {
            numbersView.setFrame(numbersCenter: numbersView.center, animationCenter: finalAnimationLocation.center)
            firstOpen = false
        }
        header.layer.borderColor = UIColor.black.cgColor
        header.layer.borderWidth = 1
        blackShadow.layer.cornerRadius = blackShadow.frame.height / 2
        grayShadow.layer.cornerRadius = blackShadow.frame.height / 2
        restartButton.bounds = CGRect(x: 0, y: 0, width: 120, height: 40.78)
        nextButton.bounds = CGRect(x: 0, y: 0, width: 120, height: 40.78)
        restartButton.layer.cornerRadius = 23
        nextButton.layer.cornerRadius = 23
    }
    
    @IBAction func onHelp(_ sender: Any) {
        print("HELP BUTTON PRESSED")
    }
    
    @IBAction func onRetry(_ sender: Any) {
        numbersView.retry()
        let name = self.numbersView.getLast()
        self.animationImage.image = UIImage(named: name)
        
    }
    
    @IBAction func onKeepPlaying(_ sender: Any) {
        currentSymbolIndex! += 1
        if (currentSymbolIndex! >= symbolSequence.count) {
            currentSymbolIndex = 0
        }
        UIView.animate(withDuration:0.3, animations: {
            self.numbersView.alpha = 0
        }, completion: {(value: Bool) in
            UIView.animate(withDuration:0.3, animations: {
                self.numbersView.alpha = 1
            })
        })
        restartAnimations()
    }
    
    @IBAction func onRestart(_ sender: Any) {
        restartAnimations()
    }
    
    func restartAnimations () {
        levelName.text = symbolSequence[currentSymbolIndex!].prefix(1).capitalized + symbolSequence[currentSymbolIndex!].dropFirst()
        numbersView.restart(symbol: symbolSequence[currentSymbolIndex!])
        UIView.animate(withDuration:0.3, animations: {
            self.youWin.alpha = 0
            self.winMessage.alpha = 0
            self.nextButton.alpha = 0
            self.restartButton.alpha = 0
        })
        UIView.animate(withDuration:0.5, delay: 0.3, animations: {
            self.levelName.alpha = 1
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            UIView.animate(withDuration:0.5, animations: {
                   self.levelName.alpha = 0
               })
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            let name = self.numbersView.getLast()
            self.animationImage.image = UIImage(named: name)
            UIView.animate(withDuration:0.3, animations: {
                self.clockView.alpha = 1
                self.camera.alpha = 1
                self.roundArrow.alpha = 1
                self.filmStrip.alpha = 1
                self.blackShadow.alpha = 1
                self.grayShadow.alpha = 1
                self.header.alpha = 1
                self.view.backgroundColor = UIColor(red: 0.373, green: 0.514, blue: 0.651, alpha: 1)
            })
            UIView.animate(withDuration:0.3, delay: 0.9, animations: {
                self.animationImage.alpha = 1
                self.filmBackground.alpha = 1
            })
        }
    }
}

extension ClockViewController: NumbersViewDelegate {
    func setAnimationImage(image: String) {
        animationImage.image = UIImage(named: image)
    }
    
    func whenAnimatingEnd() {
        UIView.animate(withDuration:0.1, delay: 0, animations: {
           self.animationImage.alpha = 0.0
           self.filmBackground.alpha = 0
        })
        UIView.animate(withDuration:0.2, delay: 0.3, animations: {
            self.camera.alpha = 0
            self.roundArrow.alpha = 0
            self.dialogue.isHidden = true
        })
    }
    
    func whenFinished() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animationImage.stopAnimating()
            var animationImages: [UIImage] = []
            for n in 1...8 {
                animationImages.append(UIImage(named: String(n) + "_" + self.symbolSequence[self.currentSymbolIndex!])!)
            }
            UIView.animate(withDuration: 0.3, delay: 0.1, animations: {
                self.clockView.alpha = 0.0
                self.filmStrip.alpha = 0
                self.blackShadow.alpha = 0
                self.grayShadow.alpha = 0
                self.view.backgroundColor = UIColor.white
                self.header.alpha = 0
                
            }, completion: {[weak self] finished in
                UIView.animate(withDuration: 0.3, delay: 0.3, animations: {
                    self?.youWin.alpha = 1.0
                })
                UIView.animate(withDuration: 0.3, delay: 0.35, animations: {
                    self?.winMessage.alpha = 1.0
                })
                UIView.animate(withDuration: 0.3, delay: 0.4, animations: {
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

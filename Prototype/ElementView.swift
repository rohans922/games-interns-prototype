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
    
    private var location: CGPoint?
    private var imageName: String?
    private var index: Int?
    private var swapIndices: [Int] = []
    
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
    }
    
    func getIndex() -> Int {
        return index!
    }
    
    func setImageName(image: String) {
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

}

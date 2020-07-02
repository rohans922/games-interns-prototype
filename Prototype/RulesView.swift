//
//  RulesView.swift
//  Prototype
//
//  Created by Shandler Mason on 7/2/20.
//  Copyright © 2020 2020 Interns. All rights reserved.
//

import UIKit

class RulesView: UIView {
    
  
    @IBOutlet weak var rulesView: UIView!
    
    override init(frame: CGRect) {
     super.init(frame: frame)
     commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("RulesView", owner: self, options: nil)
        //addSubview(rulesView)
        rulesView?.frame = (self.bounds)
        rulesView?.autoresizingMask=[.flexibleHeight,.flexibleWidth]
           
           setUpRules()
           
          
    }
    

    func setUpRules(){
    
    
    
    }


}

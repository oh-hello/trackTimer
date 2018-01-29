//
//  LapButton.swift
//  trackTimer
//
//  Created by SANDISH, MADELINE on 1/24/18.
//  Copyright © 2018 District196. All rights reserved.
//

import UIKit

class LapButton: UIButton {

   //MARK: Properties
    let runner:Runner
    
   //MARK: Initialization
    required init(run: Runner) {
        runner = run
        super.init(frame: .zero)
        
        backgroundColor = UIColor(red: 182/255, green: 215/255, blue: 168/255, alpha: 1.0)
        layer.cornerRadius = 20
        setTitle("Lap", for: UIControlState.normal)
        titleLabel?.font = UIFont(name: "FjallaOne-Regular", size: 30)
        setTitleColor(UIColor.black, for: UIControlState.normal)
        setTitleColor(UIColor.white, for: UIControlState.focused)
        layer.borderWidth = 2
        frame.size = CGSize(width: 60, height: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

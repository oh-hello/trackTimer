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
        
        backgroundColor = UIColor(hue: 102, saturation: 22, brightness: 84, alpha: 1)
        layer.cornerRadius = 20
        setTitle("Lap", for: UIControlState.normal)
        titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 15)
        layer.borderWidth = 2
        frame.size = CGSize(width: 60, height: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  StopButton.swift
//  trackTimer
//
//  Created by SANDISH, MADELINE on 1/30/18.
//  Copyright © 2018 District196. All rights reserved.
//

import UIKit

class StopButton: UIButton {
    
    //MARK: Properties
    let runner:Runner
    let lap:LapButton
    
    //MARK: Initialization
    required init(run: Runner, lap: LapButton) {
        runner = run
        self.lap = lap
        super.init(frame: .zero)
        
        backgroundColor = UIColor(red: 230/255, green: 184/255, blue: 175/255, alpha: 1.0)
        layer.cornerRadius = 20
        setTitle("Stop", for: UIControlState.normal)
        titleLabel?.font = UIFont(name: "FjallaOne-Regular", size: 30)
        setTitleColor(UIColor.black, for: UIControlState.normal)
        layer.borderWidth = 2
        frame.size = CGSize(width: 60, height: 50)
        
        //disable on initialization
        isEnabled = false
        
        //set disabled property styles
        setTitleColor(UIColor.darkGray, for: UIControlState.disabled)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func disableButtons() {
        lap.isEnabled = false
        lap.backgroundColor = UIColor.lightGray
        
        isEnabled = false
    }
    
}

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
    let defaultGreen = UIColor(red: 182/255, green: 215/255, blue: 168/255, alpha: 1.0)
    //MARK: Initialization
    required init(run: Runner) {
        runner = run
        super.init(frame: .zero)
        
        backgroundColor = defaultGreen
        layer.cornerRadius = 20
        setTitle("Lap", for: UIControlState.normal)
        titleLabel?.font = UIFont(name: "FjallaOne-Regular", size: 30)
        setTitleColor(UIColor.black, for: UIControlState.normal)
        setTitleColor(UIColor.lightGray, for: UIControlState.highlighted)
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
    
    //MARK: Private Functions
    func callToLap(){
        runner.lapLapTimer()
        backgroundColor = defaultGreen
    }
    
    func changeLapColor(){
        backgroundColor = UIColor.yellow
    }
    
    func revertLapColor() {
        backgroundColor = defaultGreen
    }
}

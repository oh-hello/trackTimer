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
        
        backgroundColor = UIColor.lightGray
        layer.cornerRadius = 20
        setTitle("\(runner.nameFirst) \(runner.nameLast ?? "")", for: UIControlState.normal)
        titleLabel?.font = UIFont(name: "FjallaOne-Regular", size: 30)
        setTitleColor(UIColor.black, for: UIControlState.normal)
        setTitleColor(UIColor.lightGray, for: UIControlState.highlighted)
        layer.borderWidth = 2
        frame.size = CGSize(width: 350, height: 50)
        
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
        backgroundColor = lapColor
    }
    
    func changeLapColor(){
        backgroundColor = UIColor.yellow
    }
    
    func revertLapColor() {
        backgroundColor = lapColor
    }
}

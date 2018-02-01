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
    
    //MARK: Initialization
    required init(run: Runner) {
        runner = run
        super.init(frame: .zero)
        
        backgroundColor = UIColor(red: 230/255, green: 184/255, blue: 175/255, alpha: 1.0)
        layer.cornerRadius = 20
        setTitle("Stop", for: UIControlState.normal)
        titleLabel?.font = UIFont(name: "FjallaOne-Regular", size: 30)
        setTitleColor(UIColor.black, for: UIControlState.normal)
        setTitleColor(UIColor.white, for: UIControlState.focused)
        layer.borderWidth = 2
        frame.size = CGSize(width: 60, height: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Functions
    func callToStop(){
        runner.lapLapTimer()
        runner.stopLapTimer()
        runner.getTotalTime()
        print("timer stopped")
    }

}

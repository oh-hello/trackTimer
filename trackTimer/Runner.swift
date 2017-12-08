//
//  RunnerClass.swift
//  trackTimer
//
//  Created by SANDISH, MADELINE on 12/8/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class Runner {
    
    //MARK: Properties
    
    var nameFirst: String
    var nameLast: String?
    var runnerTimes = [String]() //Determine whether times will be stored as strings or other objects
    //Are timers to be associated directly with runners?
    
    
    //MARK: Initialization
    
    init?(nameFirst: String, nameLast: String?) {
        
        //Name must not be empty
        guard !nameFirst.isEmpty else {
            return nil
        }
        
        //initialize Properties
        self.nameFirst = nameFirst
        self.nameLast = nameLast
    }

}

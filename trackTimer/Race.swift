//
//  Race.swift
//  trackTimer
//
//  Created by SANDISH, MADELINE on 12/8/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class Race {
    
    //MARK: Properties
    
    var date: String
    var location: String
    var distance: String?
    var runnerList = [Runner]()
    
    
    //MARK: Initialization
    init?(date: String, location: String, distance: String?, runnerList: Array<Runner>){
        
        //Date must not be empty
        guard !date.isEmpty else {
            return nil
        }
        
        //runnerList must have between 1 and 10 entries
        guard runnerList.count <= 10 && runnerList.count >= 1 else {
            return nil
        }
        
        //Initialize properties
        self.date = date
        self.location = location
        self.distance = distance
        self.runnerList = runnerList
    }
    
}

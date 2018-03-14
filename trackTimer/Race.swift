//
//  Race.swift
//  trackTimer
//
//  Created by SANDISH, MADELINE on 12/8/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit
import os.log

class Race: Codable {
    
    //MARK: Properties
    
    var date: String
    var location: String
    var distance: String?
    var runnerList = [Runner]()
    
    // Relay specific properties
    var relay: Bool
    var totalDuration = ""
    
    
    //MARK: Initialization
    init?(date: String, location: String, distance: String?, runnerList: Array<Runner>, relay: Bool){
        
        //Date must not be empty
        guard !date.isEmpty else {
            return nil
        }
        
        //will set the location to practice if nothing is entered
        var tempLocation = location
        if tempLocation.isEmpty {
            tempLocation = "Practice"
        }
        
        //runnerList must have between 1 and 10 entries
        guard runnerList.count <= 10 && runnerList.count >= 1 else {
            return nil
        }
        
        //Initialize properties
        self.date = date
        self.location = tempLocation
        self.distance = distance
        self.runnerList = runnerList
        self.relay = relay
        
    }
    
}

//
//  Race.swift
//  trackTimer
//
//  Created by SANDISH, MADELINE on 12/8/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit
import os.log

class Race: Codable, Equatable {
    
    //MARK: Properties
    
    var date: String
    var location: String
    var distance: String?
    var runnerList = [Runner]()
    var completed = false
    
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
    
    //MARK: Functions
    func updateRace(_ newRunnerList: [Runner]) -> Bool{
        if newRunnerList.count > 0 {
            runnerList = newRunnerList
            return true
        }
        return false
    }
    
    //MARK: Equatable adjustments
    static func == (lhs: Race, rhs: Race) -> Bool {
        return lhs.date == rhs.date && lhs.location == rhs.location && lhs.runnerList == rhs.runnerList
    }
    
}

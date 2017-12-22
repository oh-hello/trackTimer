//
//  Race.swift
//  trackTimer
//
//  Created by SANDISH, MADELINE on 12/8/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit
import os.log

class Race: NSObject, NSCoding {
    
    //MARK: Properties
    
    var date: String
    var location: String
    var distance: String?
    var runnerList = [Runner]()
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("races")
    
    //MARK: Types
    
    struct PropertyKey {
        static let date = "date"
        static let location = "location"
        static let distance = "distance"
        static let runnerList = "runnerList"
    }
    
    
    //MARK: Initialization
    init?(date: String, location: String, distance: String?, runnerList: Array<Runner>){
        
        //Date must not be empty
        guard !date.isEmpty else {
            return nil
        }
        
        //Location must not be empty
        guard !location.isEmpty else {
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
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: PropertyKey.date)
        aCoder.encode(location, forKey: PropertyKey.location)
        aCoder.encode(distance, forKey: PropertyKey.distance)
        aCoder.encode(runnerList, forKey: PropertyKey.runnerList)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The date is required. If we cannot decode a date string, the initializer should fail.
        guard let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? String else {
            os_log("Unable to decode the date for a Race object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // The runner list is required. If we cannot decode a runner list array, the initializer should fail.
        guard let runnerList = aDecoder.decodeObject(forKey: PropertyKey.runnerList) as? Array<Runner> else {
            os_log("Unable to decode the runner list for a Race object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let location = aDecoder.decodeObject(forKey: PropertyKey.location) as? String
        
        let distance = aDecoder.decodeObject(forKey: PropertyKey.distance) as? String
        
        // Must call designated initializer
        self.init(date: date, location: location!, distance: distance, runnerList: runnerList)
    }
}

//
//  GlobalData.swift
//  trackTimer
//
//  Created by SANDISH, MADELINE on 12/8/17.
//  Copyright © 2017 District196. All rights reserved.
//

import Foundation
import UIKit

var allRaces = [Race]()

//creates file name for saving races
var fileFolder: String {
    
    let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    return DocumentsDirectory.appendingPathComponent("trackTimerSaveFolder").path
}

//create a csv file for a race
func createRaceCSV(_ race: Race) -> String {
    var csv = "\(race.date),\(race.location),\(race.distance ?? "")\n"
    
    //loop to make csv
    for x in 0..<race.runnerList.count {
        csv.append("\(race.runnerList[x].nameFirst) \(race.runnerList[x].nameLast ?? ""),")
        for time in race.runnerList[x].runnerTimesFormatted {
            csv.append("\(time),")
        }
        csv.append("\n")
    }
    
    return csv
}

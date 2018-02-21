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

//
//  PersistentData.swift
//
//
//  Created by behnke on 6/24/17.
//  Copyright © 2017 George K Behnke. All rights reserved.
//

import Foundation
import os.log   // added for accessing persistent data storage

// ******* PART 2 ************** additional functionalities to basic class
class PersistentData: NSObject, NSCoding {
    
    //MARK: Properties
    var persistentRacesArray: [Race]
    var storedRace: String
    
    // ******* PART 1 **************
    //MARK: create structure to link object's Properties to variable races to archive
    struct PropertyKey {   // Race values are same name as Properties they name
        static let persistentRacesArray = "persistentRacesArray"
        static let storedRace = "storedRace"
    }
    
    // ******* PART 3 **************
    //MARK: Archiving Paths
    // This creates a path to the ArchiveURL & its file's Directory
    var DocumentsDirectory: URL
    var ArchiveURL: URL
    
    //MARK: Initialization: Create the instance of the Race to archive to long term storage
    //  This is the usual initializer for the class.
    //  races: the Race array to archive
    //  fileName: the name of the file in which to store the archive
    init?(races: [Race], raceName: String) {
        // The input Array must not be empty
        guard !races.isEmpty else {
            return nil
        }
        
        // Initialize properties.
        persistentRacesArray = races
        storedRace = raceName
        DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        ArchiveURL = DocumentsDirectory.appendingPathComponent(raceName)
    }
    
    // ******* PART 2a ********** Attach the property races to the archived races
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(persistentRacesArray, forKey: PropertyKey.persistentRacesArray)
    }
    
    // ******* PART 2b ********** create the instance with the archive information
    //Mark: coder initialization
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a races Race array, the initializer should fail.
        guard let races = aDecoder.decodeObject(forKey: PropertyKey.persistentRacesArray) as? [Race] else {
            os_log("Unable to decode the name for a PersistenRaceArray object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer to complete the object's instantiation.
        self.init(races: races, raceName: PropertyKey.storedRace)
    }
    
    // ****** PART 4a *******
    // Save Race information to long term storage
    //  str: the Race to be archived
    func archiveRace(str: [Race]) {
        persistentRacesArray = str
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(persistentRacesArray, toFile: ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Race successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save Race...", log: OSLog.default, type: .error)
        }
    }
    
    // ****** PART 4b ******
    // Read (Restore) archived Race information from storage
    // Returns nil if the Race has not yet been archived to the file
    func restoreRace() -> [Race]?  {
        let tmp = NSKeyedUnarchiver.unarchiveObject(withFile: ArchiveURL.path) as? [Race]
        return tmp
    }
}

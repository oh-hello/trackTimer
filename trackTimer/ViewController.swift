//
//  ViewController.swift
//  trackTimer
//
//  Created by SANDISH, MADELINE on 12/5/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var trackTimerLabel: UILabel!
    @IBOutlet weak var newRace: UIButton!
    @IBOutlet weak var archive: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //load data
        guard let jsonData = NSKeyedUnarchiver.unarchiveObject(withFile: fileFolder) as? Data else { return }
        let jsonDecoder = JSONDecoder()
        do {
            // Decode data
            allRaces = try jsonDecoder.decode([Race].self, from: jsonData)
        }
        catch {
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func launchSegue(_ sender: UIButton) {
        switch sender {
        case newRace:
            performSegue(withIdentifier: "toRaceCreation", sender: self)
        case archive:
            performSegue(withIdentifier: "toArchive", sender: self)
        default:
            break
        }
    
    }
    

}


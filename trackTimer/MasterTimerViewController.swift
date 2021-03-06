//
//  MasterTimerViewController.swift
//  trackTimer
//
//  Created by KRUEGER, LILLIAN on 1/5/18.
//  Copyright © 2018 District196. All rights reserved.
//

import UIKit

class MasterTimerViewController: UIViewController {
    
    //Race class autoset labels
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    //Timer Variables
    @IBOutlet weak var masterTimerClock: UILabel!
    var timer = Timer()
    var startTime = TimeInterval()
    
    //StartFunction
    @IBAction func startButton(_ sender: Any) {
        if !timer.isValid{
            let aSelector: Selector = #selector(MasterTimerViewController.runTimer)
            timer = Timer.scheduledTimer(timeInterval: 0.10, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate
        }
    }
    
    //Timer Things
    func runTimer(){
        let currentTime = NSDate.timeIntervalSinceReferenceDate
        var elapsedTime: TimeInterval = currentTime - startTime
        let minutes = UInt8(elapsedTime / 60)
        elapsedTime -= (TimeInterval(minutes) * 60)
        let seconds = UInt8(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        let fraction = UInt8(elapsedTime * 100)
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        let displayTimeLabel = "\(strMinutes):\(strSeconds):\(strFraction)"
        masterTimerClock.text = displayTimeLabel

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }

}

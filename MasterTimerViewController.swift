//
//  MasterTimerViewController.swift
//  trackTimer
//
//  Created by KRUEGER, LILLIAN on 1/2/18.
//  Copyright © 2018 District196. All rights reserved.
//
import UIKit
class MasterTimerViewController: UIViewController {
    
    //Race class autoset labels
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var race: Race?
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        if race != nil {
            print("success")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Timer
    
    //Timer Variables
    @IBOutlet weak var masterTimerClock: UILabel!
    var timer = Timer()
    var startTime = TimeInterval()
    
    //Start function
    @IBAction func startButton(_ sender: Any) {
        if !timer.isValid{
            let aSelector : Selector = #selector(MasterTimerViewController.runTimer)
            timer = Timer.scheduledTimer(timeInterval: 0.10, target: self, selector: aSelector, userInfo:nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate
        }
    }

    
    func runTimer(){
        let currentTime = NSDate.timeIntervalSinceReferenceDate
        var elapsedTime: TimeInterval = currentTime - startTime
        let minutes = UInt8(elapsedTime / 60.0)
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
    
    
    
    
    // MARK: - Navigation
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    
    /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

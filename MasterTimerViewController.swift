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
    @IBOutlet weak var runnerStack: UIStackView!
    
    var race: Race?
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        //set up heading fields
        dateLabel.text = race?.date
        locationLabel.text = race?.location
        distanceLabel.text = race?.distance
        print("In theory things have been set")
        
        setupRunnerStack()
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
    
    //MARK: Private Methods
    
    func setupRunnerStack() {
        
        for view in runnerStack.arrangedSubviews{
            runnerStack.removeArrangedSubview(view)
        }
        
        for x in 0..<race!.runnerList.count {
            //create sub array
            var subArray = [UIView]()
            
            //access runner
            let currentRunner = race?.runnerList[x]
            
            //create Name Label
            let runnerName = UILabel()
            runnerName.text = "\(String(describing: currentRunner?.nameFirst)) \(String(describing: currentRunner?.nameLast!))"
            
            runnerName.font = UIFont(name: "OpenSans-Regular", size: 20)
            
            
            //create Buttons
            let lap = LapButton(run: currentRunner!)
            
            //add to array
            subArray.append(runnerName)
            subArray.append(lap)
            
            //add to stack
            
            
            
            
        }
    }
    
    
    // MARK: - Navigation
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
}

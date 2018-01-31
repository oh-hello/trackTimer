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
    
    @IBOutlet weak var startAll: UIButton!
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
        
        //format start all button
        startAll.layer.borderWidth = 2
        startAll.layer.cornerRadius = 10
        
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
        startLapTime()
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
    
    func startLapTime(){
        for currentRunner in race!.runnerList{
            currentRunner.startLapTimer()
            print("lap timer started")
        }
    }

    
    //MARK: Private Methods
    
    func setupRunnerStack() {
        
        for view in runnerStack.arrangedSubviews{
            runnerStack.removeArrangedSubview(view)
        }
        
        for x in 0..<race!.runnerList.count {

            //access runner
            let currentRunner = race?.runnerList[x]
            
            //create Name Label
            let runnerName = UILabel()
            runnerName.text = "\(currentRunner?.nameFirst ?? "Runner") \(currentRunner?.nameLast ?? "")"
            
            runnerName.font = UIFont(name: "OpenSans-Regular", size: 20)
            
            
            //create Buttons
            let lap = LapButton(run: currentRunner!)
            let stop = StopButton(run: currentRunner!)
            
            //add event listeners
            lap.addTarget(self, action: #selector(lapButtonPressed),for: .touchUpInside)
            stop.addTarget(self, action: #selector(stopButtonPressed), for: .touchUpInside)
            
            //Create horizontal stack
            let subArray = [UIView]()
            let horizontalStack = UIStackView(arrangedSubviews: subArray)
            horizontalStack.axis = .horizontal
            horizontalStack.distribution = .fillEqually
            horizontalStack.spacing = 10
            
            //add to stack
            horizontalStack.addArrangedSubview(runnerName)
            horizontalStack.addArrangedSubview(lap)
            horizontalStack.addArrangedSubview(stop)
            
            //add to vertical stack
            runnerStack.addArrangedSubview(horizontalStack)
            
        }
    }
    
    //MARK: Actions
    
    func lapButtonPressed(sender: LapButton){
        sender.callToLap()
        print("Lap Button Pressed from MasterTimer")
    }
    
    func stopButtonPressed(sender: StopButton){
        print("Stop Button Pressed")
    }
    
    
    // MARK: - Navigation
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
}

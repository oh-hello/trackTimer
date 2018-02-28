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
    @IBOutlet weak var saveRace: UIButton!
    @IBOutlet weak var startAll: UIButton!
    var race: Race?
    var buttonArray = [UIButton]()
    
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
        
        //disable save button
        saveRace.isEnabled = false
        
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
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: aSelector, userInfo:nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate
        }
        enableButtons()
        startLapTime()
        startAll.isEnabled = false
    }

    @objc func runTimer(){
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
        }
    }

    
    //MARK: Private Methods
    
    func setupRunnerStack() {
        buttonArray = []
        
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
            let stop = StopButton(run: currentRunner!, lap: lap)
            
            //add buttons to button array
            buttonArray.append(lap)
            buttonArray.append(stop)
            
            //add event listeners for touch up inside
            lap.addTarget(self, action: #selector(lapButtonPressed),for: .touchUpInside)
            stop.addTarget(self, action: #selector(stopButtonPressed), for: .touchUpInside)
            
            //add event listeners for touch enters
            lap.addTarget(self, action: #selector(lapButtonTouched), for: .touchDown)
            lap.addTarget(self, action: #selector(lapButtonTouched), for: .touchDragEnter)
            lap.addTarget(self, action: #selector(lapTouchExit), for: .touchDragExit)
            
            //Create horizontal stack
            let subArray = [UIView]()
            let horizontalStack = UIStackView(arrangedSubviews: subArray)
            horizontalStack.axis = .horizontal
            horizontalStack.distribution = .fillEqually
            horizontalStack.spacing = 10
            
            //add to horizontal stack
            horizontalStack.addArrangedSubview(runnerName)
            horizontalStack.addArrangedSubview(lap)
            horizontalStack.addArrangedSubview(stop)
            
            //add to vertical stack
            runnerStack.addArrangedSubview(horizontalStack)
            
        }
    }
    
    func checkButtonsDisabled() -> Bool {
        for button in buttonArray{
            if button.isEnabled == true {
                return false
            }
        }
        return true
    }
    
    //MARK: Actions
    
    func enableButtons() {
        for button in buttonArray {
            button.isEnabled = true
        }
        
    }
    
    @objc func lapButtonPressed(sender: LapButton){
        sender.callToLap()
    }
    
    @objc func lapButtonTouched(sender: LapButton){
        sender.changeLapColor()
    }
    
    @objc func lapTouchExit(sender: LapButton) {
        sender.revertLapColor()
    }
    
    @objc func stopButtonPressed(sender: StopButton){
        sender.callToStop()
        sender.disableButtons()
        
        if checkButtonsDisabled() == true {
            timer.invalidate()
            
            saveRace.isEnabled = true
        }
        
    }
    
    // MARK: - Navigation
    @IBAction func segueToRaceReport(_ sender: Any) {
        performSegue(withIdentifier: "toRaceReport", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        
        switch segue.destination{
        case is RaceCreationViewController:
            cancel(sender as Any)
        default:
            
        //append current race to global race array
        allRaces.insert(race!, at: 0)
       
        // Encode data
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(allRaces)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print("JSON String : " + jsonString!)
            //save data
            NSKeyedArchiver.archiveRootObject(jsonData, toFile: fileFolder)
        }
        catch {
        }
        
        let destination = segue.destination as? RaceReportViewController
        destination!.race = self.race
        }
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
}

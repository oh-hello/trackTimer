//
//  RaceReportViewController.swift
//  trackTimer
//
//  Created by KRUEGER, LILLIAN on 1/31/18.
//  Copyright © 2018 District196. All rights reserved.
//

import UIKit

class RaceReportViewController: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var reportScroll: UIScrollView!
    @IBOutlet weak var timeReportStack: UIStackView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var runNowButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var exportButton: UIButton!
    
    var race: Race?
    
    //MARK: Life Cycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        //set up heading fields
        dateLabel.text = race?.date
        locationLabel.text = race?.location
        distanceLabel.text = race?.distance
        
        //set up relay duration labels
        switch race!.relay {
        case true:
            totalLabel.isHidden = false
            timeLabel.isHidden = false
            timeLabel.text = race!.totalDuration
        default:
            totalLabel.isHidden = true
            timeLabel.isHidden = true
        }
        
        //Make Buttons available based on race state
        switch race!.completed {
        case true:
            exportButton.isHidden = false
        default:
            runNowButton.isHidden = false
            editButton.isHidden = false
        }
        
        reportScroll.contentInset.left = 20.0
        
        setUpTimeReportStack()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Private Methods
    
    func setUpTimeReportStack(){
        for view in timeReportStack.arrangedSubviews{
            timeReportStack.removeArrangedSubview(view)
        }
        
        for x in 0..<race!.runnerList.count{
            
            //access runner
            let currentRunner = race?.runnerList[x]
            
            //create Name Label
            let runnerName = UILabel()
            runnerName.text = "\(currentRunner?.nameFirst ?? "Runner") \(currentRunner?.nameLast ?? "")"
            
            runnerName.font = UIFont(name: "OpenSans-Regular", size: 20)
            
            //Create horizontal stack
            let subArray = [UIView]()
            let horizontalStack = UIStackView(arrangedSubviews: subArray)
            horizontalStack.axis = .horizontal
            horizontalStack.distribution = .fillEqually
            horizontalStack.spacing = 10
            //horizontalStack.
            
            //add to stack
            horizontalStack.addArrangedSubview(runnerName)
            
            //add times to stack
            for runTime in (currentRunner?.runnerTimesFormatted)!{
                let timeLabel = UILabel()
                timeLabel.text = runTime
                timeLabel.font = UIFont(name: "OpenSans-Regular", size: 20)
                horizontalStack.addArrangedSubview(timeLabel)
            }
            
            //add to vertical stack
            timeReportStack.addArrangedSubview(horizontalStack)
        }
    }
    
    //MARK: Export
    
    @IBAction func export(_ sender: UIButton) {
        let fileName = "\(race?.location ?? "Practice") \(race?.distance ?? "").csv"
        let path = NSURL(fileURLWithPath:NSTemporaryDirectory()).appendingPathComponent(fileName)
        //call to create race csv
        let raceCSV = createRaceCSV(race!)
        print(raceCSV)
        
        //save the race csv file
        do {
            try raceCSV.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
        }
        catch {
            print("Failed to create file")
            print("\(error)")
        }
        
        //create activity popover
        let activityView = UIActivityViewController(activityItems: [path!], applicationActivities:[])
        //modify activities
        activityView.excludedActivityTypes = [UIActivityType.assignToContact,UIActivityType.assignToContact,UIActivityType.saveToCameraRoll,UIActivityType.postToFlickr,UIActivityType.postToVimeo,UIActivityType.postToTencentWeibo,UIActivityType.postToTwitter,UIActivityType.postToFacebook,UIActivityType.openInIBooks]
        //present popover
        activityView.modalPresentationStyle = UIModalPresentationStyle.popover
        present(activityView, animated: true, completion: nil)
        let popOver = activityView.popoverPresentationController
        popOver?.sourceView = sender
    }
    
    //MARK: Navigation
    @IBAction func backToArchive(_ sender: Any) {
        performSegue(withIdentifier: "toArchiveFromReport", sender: sender)
    }
    
    @IBAction func runSavedRace(_ sender: Any) {
        performSegue(withIdentifier: "toTimerFromReport", sender: sender)
    }
    
    @IBAction func editSavedRace(_ sender: Any) {
        performSegue(withIdentifier: "toRaceCreationFromReport", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        
        switch segue.destination{
        case is ArchiveViewController:
            break
        case is RaceCreationViewController:
            let destination = segue.destination as? RaceCreationViewController
            destination!.race = self.race
            destination!.editingRace = true
        default:
            let destination = segue.destination as? MasterTimerViewController
            destination!.race = self.race
        }
        
    }
}

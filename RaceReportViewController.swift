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
    
    var race: Race?
    
    //MARK: Life Cycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        //set up heading fields
        dateLabel.text = race?.date
        locationLabel.text = race?.location
        distanceLabel.text = race?.distance
        
        
        
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
    //MARK: Navigation
    
    
    
}

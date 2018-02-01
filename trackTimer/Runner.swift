//
//  RunnerClass.swift
//  trackTimer
//
//  Created by SANDISH, MADELINE on 12/8/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class Runner {
    
    //MARK: Properties
    
    var nameFirst: String
    var nameLast: String?
    var runnerTimes = [String]()
    var lapTimer = Timer()
    var placeHolder = 0
    var count = 0
    var runnerTimesDoubles = [Double]()
    var runnerTimesDifference = [Double]()
    var runnerTimesFormatted = [String]()
    var currentTimeTotal = TimeInterval()
    var firstTime = TimeInterval()
    
    //buttons for start and stop
    let lapButton = UIButton()
    let stopButton = UIButton()
    //MARK: Initialization
    
    init?(nameFirst: String, nameLast: String?) {
        
        //Name must not be empty
        guard !nameFirst.isEmpty else {
            return nil
        }
        
        //initialize Properties
        self.nameFirst = nameFirst
        self.nameLast = nameLast
    }
    
    //MARK: Methods
    
    func startLapTimer(){
        if !lapTimer.isValid{
            let aSelector : Selector = #selector(Runner.updateLapTimer)
            lapTimer = Timer.scheduledTimer(timeInterval: 0.10, target: self, selector: aSelector, userInfo: nil, repeats: true)
        }
    }
    
    func stopLapTimer(){
        lapTimer.invalidate()
        runnerTimesDoubles.append(currentTimeTotal)
        convertDifference()
        runnerTimesDifference.remove(at: 0)
        convertFormat()
    }
    
    func lapLapTimer(){
        lapTimer.invalidate()
        updateLapTimer()
        runnerTimesDoubles.append(currentTimeTotal)
        convertDifference()
    }
    
    @objc func updateLapTimer(){
        let currentTime = NSDate.timeIntervalSinceReferenceDate
        currentTimeTotal = currentTime
        if placeHolder == 0{
            firstTime = currentTime
            runnerTimesDoubles.append(firstTime)
            placeHolder = 1
        }
    }
    
    func convertDifference(){
        if count != 0{
            runnerTimesDifference.append(runnerTimesDoubles[count] - runnerTimesDoubles[count - 1])
            count += 1
        }
        if count == 0{
            runnerTimesDifference.append(runnerTimesDoubles[count])
            count += 1
        }
    }
    
    func convertFormat(){
        for element in runnerTimesDifference{
            var minutes = 0.0
            var seconds = 0.0
            var minutesInt = Int()
            var secondsInt = Int()
            if element <= 60{
                minutesInt = 0
                seconds = element
                seconds = round(100 * seconds) / 100
                secondsInt = Int(seconds)
            }
            else{
                minutes = element / 60
                minutesInt = Int(minutes)
                let minutesDouble = Double(minutesInt)
                seconds = (element - 60 * minutesDouble)
                seconds = round(100 * seconds) / 100
                secondsInt = Int(seconds)
            }
            if secondsInt < 10 {
                let time = "\(minutesInt):0\(secondsInt)"
                runnerTimesFormatted.append(time)
            }
            else{
                let time = "\(minutesInt):\(secondsInt)"
                runnerTimesFormatted.append(time)
            }
        }
    }
    
}

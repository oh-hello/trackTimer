//
//  RunnerClass.swift
//  trackTimer
//
//  Created by SANDISH, MADELINE on 12/8/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class Runner: Codable, Equatable {
    
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
    var finalTime = 0.0
    
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
    
    //MARK: Codable adjustments
    private enum CodingKeys: String, CodingKey {
        case nameFirst
        case nameLast
        case runnerTimesFormatted
    }
    
    //MARK: Equatable adjustments
    static func == (lhs: Runner, rhs: Runner) -> Bool {
        return lhs.nameFirst == rhs.nameFirst && lhs.runnerTimesFormatted == rhs.runnerTimesFormatted
    }
    
    //MARK: Methods
    
    func startLapTimer(){
        if !lapTimer.isValid{
            let aSelector : Selector = #selector(Runner.updateLapTimer)
            lapTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        }
    }
    
    func stopLapTimer(){
        convertDifference()
        runnerTimesDifference.remove(at: 0)
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
            var milliSeconds = 0.0
            var minutesInt = Int()
            var secondsInt = Int()
            var milliSecondsInt = Int()
            if element <= 60{
                minutesInt = 0
                seconds = element
                seconds = round(100 * seconds) / 100
                secondsInt = Int(seconds)
                milliSeconds = abs(Double(secondsInt) - seconds)
                milliSeconds = round(100 * milliSeconds) / 100
                milliSeconds *= 100
                milliSecondsInt = Int(milliSeconds)
                print(milliSeconds)
                print(milliSecondsInt)
            }
            else{
                minutes = element / 60
                minutesInt = Int(minutes)
                let minutesDouble = Double(minutesInt)
                seconds = (element - 60 * minutesDouble)
                seconds = round(100 * seconds) / 100
                secondsInt = Int(seconds)
                milliSeconds = abs(Double(secondsInt) - seconds)
                milliSeconds = round(100 * milliSeconds) / 100
                milliSeconds *= 100
                milliSecondsInt = Int(milliSeconds)
                print(milliSeconds)
                print(milliSecondsInt)
            }
            if secondsInt < 10 {
                if milliSeconds < 10 {
                    let time = "\(minutesInt):0\(secondsInt).0\(milliSecondsInt)"
                    runnerTimesFormatted.append(time)
                }
                else {
                    let time = "\(minutesInt):0\(secondsInt).\(milliSecondsInt)"
                    runnerTimesFormatted.append(time)
                }
            }
            else{
                if milliSeconds < 10 {
                    let time = "\(minutesInt):\(secondsInt).0\(milliSecondsInt)"
                    runnerTimesFormatted.append(time)
                }
                else {
                    let time = "\(minutesInt):\(secondsInt).\(milliSecondsInt)"
                    runnerTimesFormatted.append(time)
                }
            }
        }
    }
    
    func getTotalTime(){
        for x in runnerTimesDifference{
            finalTime += x
        }
        runnerTimesDifference.append(finalTime)
        convertFormat()
    }
    
}

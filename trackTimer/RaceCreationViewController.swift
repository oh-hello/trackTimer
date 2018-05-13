//
//  RaceCreationViewController.swift
//  trackTimer
//
//  Created by SANDISH, MADELINE on 12/7/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit
import os.log

class RaceCreationViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    let pickerData = [[1,2,3,4,5,6,7,8,9,10]]
    
    //MARK: Properties
    @IBOutlet weak var viewScroller: UIScrollView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var distanceField: UITextField!
    @IBOutlet weak var numberPicker: UIPickerView!
    @IBOutlet weak var runNowButton: UIButton!
    @IBOutlet weak var saveForLaterButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var runController: RunnerControl!
    @IBOutlet weak var relaySwitch: UISwitch!
    @IBOutlet weak var numRunLabel: UILabel!
    
    //Race contstructed based on race info input by user
    var race: Race?
    var runnerList = [Runner]()
    
    //Race editing controller
    var editingRace = false

    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberPicker.delegate = self
        numberPicker.dataSource = self
        // Handle the text field’s user input through delegate callbacks
        locationField.delegate = self
        distanceField.delegate = self
        
        //add listener to switch
        relaySwitch.addTarget(self, action: #selector(switchToggled(_:)), for: UIControlEvents.valueChanged)
        
        //manage keyboard changes
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        //automatically sets race date when view loads
        let currentDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateStyle = .short
        dateLabel.text = dateFormatter.string(from: currentDate as Date)
        
        //correct format from relay if race is cancelled
        relaySwitch.isOn = false
        numRunLabel.isHidden = false
        numberPicker.isHidden = false
        
        //Set default picker value and RunnerControl Fields when view loads
        numberPicker.selectRow(0, inComponent: 0, animated: false)
        runController.updateNumberOfTextfields(pickerData[0][numberPicker.selectedRow(inComponent:0)])
        
        //format view to edit existing Race
        if race != nil {
            dateLabel.text = race?.date
            locationField.text = race?.location
            distanceField.text = race?.distance
            
            numberPicker.selectRow(race!.runnerList.count - 1, inComponent: 0, animated: false)
            runController.updateNumberOfTextfields(race!.runnerList.count)
            
            relaySwitch.isOn = race!.relay
            numRunLabel.isHidden = race!.relay
            numberPicker.isHidden = race!.relay
            
            for x in 0..<runController.allNameFields.count {
                runController.allNameFields[x][0].text = race?.runnerList[x].nameFirst
                runController.allNameFields[x][1].text = race?.runnerList[x].nameLast
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UIPickerView Delegate and Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(_
        pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int
        ) -> String? {
        return String(pickerData[component][row])
    }
    
    //Indicates a row was selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        //Update runner initialization
        runController.updateNumberOfTextfields(pickerData[component][row])
        
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 200
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }

    //MARK: Switch Manager
    
    @objc func switchToggled(_ sender: UISwitch){
        switch relaySwitch.isOn {
        case true:
            //set numberPicker to 4
            numberPicker.selectRow(3, inComponent: 0, animated: false)
            pickerView(numberPicker, didSelectRow: 3, inComponent : 0)
            numberPicker.isHidden = true
            numRunLabel.isHidden = true
        default:
            //set numberPicker back to 1
            numberPicker.selectRow(0, inComponent: 0, animated: false)
            pickerView(numberPicker, didSelectRow: 0, inComponent : 0)
            numberPicker.isHidden = false
            numRunLabel.isHidden = false
        }
    }
    
    
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the Keyboard
        textField.resignFirstResponder()
        return true
    }
    
    //manage changes to frame due to keyboard
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            viewScroller.contentInset = UIEdgeInsets.zero
        } else {
            viewScroller.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        viewScroller.scrollIndicatorInsets = viewScroller.contentInset
    }
    
    
    //MARK: Private Methods
   
    func createRace(_ date: String, _ location: String, _ distance: String, _ runnerList: Array<Runner>, _ relay: Bool)  {
        race = Race(date: date, location: location, distance: distance, runnerList: runnerList, relay: relay)
    }
    
    func createRunners() -> Array<Runner> {
        var runnerArray = [Runner]()
        for run in runController.allNameFields{
            let nameFirst = run[0].text
            let nameLast = run[1].text
            let runner = Runner(nameFirst: nameFirst ?? "", nameLast: nameLast ?? "")
            
            //catch empty runner
            switch runner{
            case nil:
                return []
            default:
                runnerArray.append(runner!)
            }
            
        }
        return runnerArray
    }
    
    func showNilRaceAlert() {
        let alertController = UIAlertController(title: "Race Error", message: "The race could not be created. Please make sure each runner has a first name.", preferredStyle: .actionSheet)
        
        let defaultAction = UIAlertAction(title: "Dismiss", style: .default, handler: { (alert: UIAlertAction!) -> Void in
         //  Do some action here.
         })
        
        
        /*let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
            //  Do something here upon cancellation.
        })*/
        
        alertController.addAction(defaultAction)
        //alertController.addAction(deleteAction)
        //alertController.addAction(cancelAction)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        self.present(alertController, animated: false, completion: nil)
    }
    
    // MARK: - Navigation
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func saveRace(_ sender: UIButton) {
        var raceOk:Bool
        //Setup Runners to pass
        runnerList = createRunners()
        
        //update edited Race
        if race != nil {
            raceOk = race!.updateRace(runnerList)
        }
            
        else{
            //Setup Race to pass
            let date = dateLabel.text
            let location = locationField.text
            let distance = distanceField.text
            createRace(date!, location!, distance!, runnerList, relaySwitch.isOn)
            
            //check for nil race
            if race == nil {
                raceOk = false
            }
            else{
                raceOk = true
            }
        }
        
        //check if Race nil and perform segue
        switch raceOk{
        case false:
            showNilRaceAlert()
        default:
            if sender == saveForLaterButton {
                if !editingRace{
                    allRaces.insert(race!, at: 0)
                }
                encodeData()
                cancel(sender)
            }
            
            performSegue(withIdentifier: "toTimer", sender: sender)
        }
    }
    
    
    //configure view controller before it's presented
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for:segue, sender: sender)
        
        switch segue.destination {
        case is ViewController:
            //perform segue to landing screen
            cancel(sender as Any)
        default:
            //Set Destination and perform segue to Master Timer
            let destination = segue.destination as? MasterTimerViewController
            destination!.race = self.race
        }
    
        
    }

}

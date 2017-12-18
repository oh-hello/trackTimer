//
//  RaceCreationViewController.swift
//  trackTimer
//
//  Created by SANDISH, MADELINE on 12/7/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class RaceCreationViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    let pickerData = [[1,2,3,4,5,6,7,8,9,10]]
    
    //MARK: Properties
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var distanceField: UITextField!
    @IBOutlet weak var numberPicker: UIPickerView!
    @IBOutlet weak var pickerTest: UILabel! //delete this outlet later
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberPicker.delegate = self
        numberPicker.dataSource = self

        //automatically sets race date when view loads
        let currentDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateStyle = .short
        dateLabel.text = dateFormatter.string(from: currentDate as Date)
        
        //Set default picker value when view loads
        numberPicker.selectRow(0, inComponent: 0, animated: false)
        updateLabel()
        
        //test values in UITextFields
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Delegate and Data Source
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
    
    //MARK: Actions
    
    //updates the label based on picker view selection
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        updateLabel()
    }
    
    func updateLabel(){
        
        let numRunners = pickerData[0][numberPicker.selectedRow(inComponent:0)]
        
        pickerTest.text = String(numRunners)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

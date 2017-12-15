//
//  RaceCreationViewController.swift
//  trackTimer
//
//  Created by SANDISH, MADELINE on 12/7/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class RaceCreationViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //automatically set race date when view loads
        let currentDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateStyle = .short
        dateLabel.text = dateFormatter.string(from: currentDate as Date)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

//
//  ArchiveViewController.swift
//  trackTimer
//
//  Created by KRUEGER, LILLIAN on 2/8/18.
//  Copyright © 2018 District196. All rights reserved.
//

import UIKit

var myIndex = 0

class ArchiveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var archiveTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("in numberOfRowsInSection")
        return allRaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("in cellForRowAt")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = allRaces[indexPath.row].date
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("segueToRaceReport")
        myIndex = indexPath.row
        performSegue(withIdentifier: "toRaceReportFromArchive", sender: self)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        
        print("calls prepare")
        switch segue.destination{
        case is ViewController:
            back(sender as Any)
        default:
            let destination = segue.destination as? RaceReportViewController
            destination!.race = allRaces[myIndex]
            print("entered switch")
        }
    }
    
    @IBAction func back(_ sender: Any){
        dismiss(animated: false, completion: nil)
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
 
    
}

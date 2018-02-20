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
    
    var sortedRaces = [Race]()
    @IBOutlet weak var archiveTable: UITableView!
    
    func sortRaces(){
        sortedRaces = allRaces.reversed()
    }
    
    //MARK: Private Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedRaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create cells
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sortedRaces[indexPath.row].date + " " + sortedRaces[indexPath.row].location + " " + sortedRaces[indexPath.row].distance!
        cell.textLabel?.font = UIFont(name: "OpenSans-Bold", size: 30)
        return cell
    }
    
    //MARK: Navigation
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        myIndex = indexPath.row
        performSegue(withIdentifier: "toRaceReportFromArchive", sender: self)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toViewControllerFromArchive", sender: sender)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "toRaceReportFromArchive" {
            let destination = segue.destination as? RaceReportViewController
            destination!.race = sortedRaces[myIndex]
        }
    }
    
    @IBAction func back(_ sender: Any){
        dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        sortRaces()
    }
 
    
}

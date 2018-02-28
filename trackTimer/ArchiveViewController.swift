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
    
    
    //MARK: Private Functions
    //sets numbers of rows that the table has
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRaces.count
    }
    
    //creates cells and how the cell is named
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = allRaces[indexPath.row].date + " " + allRaces[indexPath.row].location + " " + allRaces[indexPath.row].distance!
        return cell
    }
    
    //deletes cells
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //delete race from array and table
            allRaces.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            //remove race from persistent archive
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
        }
    }
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction: UITableViewRowAction, indexPath: IndexPath) -> Void in
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
            destination!.race = allRaces[myIndex]
        }
    }
    
    @IBAction func back(_ sender: Any){
        dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
}

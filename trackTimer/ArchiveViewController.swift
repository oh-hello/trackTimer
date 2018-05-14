//
//  ArchiveViewController.swift
//  trackTimer
//
//  Created by KRUEGER, LILLIAN on 2/8/18.
//  Copyright © 2018 District196. All rights reserved.
//

import UIKit



class ArchiveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var archiveTable: UITableView!
    var myIndex = 0
    
    //MARK: Table Functions
    //sets numbers of rows that the table has
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRaces.count
    }
    
    //creates cells and how the cell is named
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let label1 = UILabel(frame: CGRect(x: 15, y: 0, width: 2 * cell.frame.width/3, height: cell.frame.height))
        
        let label2 = UILabel(frame: CGRect(x: 2 * cell.frame.width/3, y: 0, width: cell.frame.width/3.25, height: cell.frame.height))
        
        label1.text = allRaces[indexPath.row].date + " " + allRaces[indexPath.row].location + " " + allRaces[indexPath.row].distance!
        
        if allRaces[indexPath.row].completed {
            label2.text = "Completed"
        }
        else {
            label2.text = "Saved"
        }
        
        label2.textAlignment = .right
        
        cell.addSubview(label1)
        
        cell.addSubview(label2)
        
        return cell
    }
    
    //deletes cells
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //delete race from array and table
            allRaces.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            //remove race from persistent archive
            encodeData()
        }
    }
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction: UITableViewRowAction, indexPath: IndexPath) -> Void in
    }
    
    //MARK: Actions
    
    @IBAction func exportAllRaces(_ sender: UIButton) {
        print("export called")
        
        let currentDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = NSLocale.current
        
        let fileName = "All Race Export \(dateFormatter.string(from: currentDate as Date)).csv"
        let path = NSURL(fileURLWithPath:NSTemporaryDirectory()).appendingPathComponent(fileName)
        
        //call to create race csv
        let allRacesCSV = createAllRacesCSV()
        print(allRacesCSV)
        
        //save the race csv file
        do {
            try allRacesCSV.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
        }
        catch {
            print("Failed to create file")
            print("\(error)")
        }
        
        //create activity popover
        let archiveActivityView = UIActivityViewController(activityItems: [path!], applicationActivities:[])
        //modify activities
        archiveActivityView.excludedActivityTypes = [UIActivityType.assignToContact,UIActivityType.assignToContact,UIActivityType.saveToCameraRoll,UIActivityType.postToFlickr,UIActivityType.postToVimeo,UIActivityType.postToTencentWeibo,UIActivityType.postToTwitter,UIActivityType.postToFacebook,UIActivityType.openInIBooks]
        //present popover
        archiveActivityView.modalPresentationStyle = UIModalPresentationStyle.popover
        present(archiveActivityView, animated: true, completion: nil)
        let popOver = archiveActivityView.popoverPresentationController
        popOver?.sourceView = sender
        popOver?.permittedArrowDirections = []
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

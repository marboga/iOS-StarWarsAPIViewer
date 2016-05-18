//
//  ViewController.swift
//  StarWarsEncyclopedia
//
//  Created by Michael Arbogast on 5/16/16.
//  Copyright © 2016 Michael Arbogast. All rights reserved.
//

import UIKit

class PeopleViewController: UITableViewController {
    
    var people = [String]()
    var personToSend = [NSDictionary]()
    var url: NSURL? = NSURL(string: "http://swapi.co/api/people/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        StarWarsModel.getAllPeople() {
//        let session = NSURLSession.sharedSession()
//        let task = session.dataTaskWithURL(url!, completionHandler: {
            data, response, error in
            do {
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                    if let results = jsonResult["results"] {
                        let resultsArray = results as! NSArray
                        print(resultsArray.count)
//                        print("super", jsonResult)
                        for i in 0..<resultsArray.count{
                            print(resultsArray[i].valueForKey("name")!)
                            self.people.append(String(resultsArray[i].valueForKey("name")!))
                            self.personToSend.append(resultsArray[i] as! NSDictionary)
                        }
                        if String(jsonResult.valueForKey("next")!) != "<null>" {
                            print(String(jsonResult.valueForKey("next")!))
                            StarWarsModel.url = NSURL(string: String(jsonResult.valueForKey("next")!))
                            self.viewDidLoad()
                        } else {
                            print("OH NOTE")
                        }
                        dispatch_async(dispatch_get_main_queue(), {
                            self.tableView.reloadData()
                        })
                    }
                }
                
            } catch {
                print("error")
            }
        }
        self.tableView.reloadData()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PersonCell")!
        cell.textLabel?.text = people[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("PersonDetailSegue", sender: tableView.cellForRowAtIndexPath(indexPath))
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("made it here")
        let controller = segue.destinationViewController as! PersonDetailViewController
        print(sender)
        
        if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
            print(indexPath.row)
            print(people[indexPath.row])
            controller.personDataToPass = personToSend[indexPath.row]
        }
    }
}


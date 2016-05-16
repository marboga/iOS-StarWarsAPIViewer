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
    var url: NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        url = NSURL(string: "http://swapi.co/api/people/")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {
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
                        }
                        
//                        print(String(jsonResult.valueForKey("next")!))
                        
                        if String(jsonResult.valueForKey("next")!) != "<null>" {
                            print(String(jsonResult.valueForKey("next")!))
                            self.url = NSURL(string: String(jsonResult.valueForKey("next")!))
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
        })
        task.resume()
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
}


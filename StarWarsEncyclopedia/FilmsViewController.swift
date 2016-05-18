//
//  FilmsViewController.swift
//  StarWarsEncyclopedia
//
//  Created by Michael Arbogast on 5/16/16.
//  Copyright © 2016 Michael Arbogast. All rights reserved.
//

import UIKit

class FilmsViewController: UITableViewController {
    
    var films = [String]()
    var filmUrl: NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        filmUrl = NSURL(string: "http://swapi.co/api/films/")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(filmUrl!, completionHandler: {
            data, response, error in
            do {
                if let jsonFilmResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                    if let results = jsonFilmResult["results"] {
                        let resultsArray = results as! NSArray
                        print(resultsArray.count)
                        print("super", jsonFilmResult)
                        for i in 0..<resultsArray.count{
                            print(resultsArray[i].valueForKey("title")!)
                            self.films.append(String(resultsArray[i].valueForKey("title")!))
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
//        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FilmCell")!
        cell.textLabel?.text = films[indexPath.row]
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("FilmDetailSegue", sender: tableView.cellForRowAtIndexPath(indexPath))
        tableView.reloadData()
    }
    
    
}

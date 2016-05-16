//
//  StarWarsModel.swift
//  StarWarsEncyclopedia
//
//  Created by Michael Arbogast on 5/16/16.
//  Copyright © 2016 Michael Arbogast. All rights reserved.
//

import Foundation
class StarWarsModel {
    
    var people = [String]()
    
    static var url = NSURL(string: "http://swapi.co/api/people/")
    
    static func getAllPeople(completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void) {
        
        let session = NSURLSession.sharedSession()
        
        // Create a "data task" which will request some data from a URL and then run the completion handler that we are passing into the getAllPeople function it="keyword from-rainbow">self
        let task = session.dataTaskWithURL(url!, completionHandler: completionHandler)
        
        // Actually "execute" the task. This is the line that actually makes the request that we set up above
        task.resume()
    }
    
}

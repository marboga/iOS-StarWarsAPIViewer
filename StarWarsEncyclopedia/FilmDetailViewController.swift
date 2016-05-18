//
//  FilmDetailViewController.swift
//  StarWarsEncyclopedia
//
//  Created by Michael Arbogast on 5/17/16.
//  Copyright © 2016 Michael Arbogast. All rights reserved.
//

import UIKit

class FilmDetailViewController: UIViewController {
    
    @IBOutlet weak var filmTitleLabel: UILabel!
    
    @IBOutlet weak var filmReleaseDateLabel: UILabel!
    
    @IBOutlet weak var filmDirectorLabel: UILabel!
    
    @IBOutlet weak var filmOpeningCrawlLabel: UILabel!
    
    var dataToPass: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataToPass)
        
        if let title = dataToPass!["title"] {
            filmTitleLabel.text = "Title: \(title)"
        }
        if let releaseDate = dataToPass!["release_date"] {
            filmReleaseDateLabel.text = "Release Date: \(releaseDate)"
        }
        if let director = dataToPass!["director"] {
            filmDirectorLabel.text = "Director: \(director)"
        }
        if let crawl = dataToPass!["opening_crawl"] {
            filmOpeningCrawlLabel.text = String(crawl)
        }
    }
    
    
    
}

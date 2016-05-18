//
//  PersonDetailViewController.swift
//  StarWarsEncyclopedia
//
//  Created by Michael Arbogast on 5/17/16.
//  Copyright © 2016 Michael Arbogast. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {
    var personDataToPass: NSDictionary?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(personDataToPass)
        
        
        if let name = personDataToPass!["name"] {
            nameLabel.text = "Name: \(name)"
        }
        if let gender = personDataToPass!["gender"] {
            genderLabel.text = "Gender: \(gender)"
        }
        if let born = personDataToPass!["birth_year"] {
            birthYearLabel.text = "Birth Year: \(born)"
        }
        if let mass = personDataToPass!["mass"] {
             massLabel.text = "Mass: \(mass)"
        }
        if let species = personDataToPass!["species"] as! NSArray? {
            debugPrint("fallaces sunt rerum species", species)
            StarWarsModel.speciesURL = String(species[0])
            StarWarsModel.getOneSpecies({ (data, response, error) in
                debugPrint(data)
                do {
                    if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                        print(jsonResult["name"]!)
                        self.speciesLabel.text = "Species: \(jsonResult["name"]!)"
                    }
                } catch {
                    print("errrrrrrrrrrrr")
                }
            })
        }
    }
}

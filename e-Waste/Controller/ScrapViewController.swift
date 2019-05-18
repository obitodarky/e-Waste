//
//  ScrapViewController.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 05/05/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit



class ScrapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet var scrapTableView: UITableView!
    let companyNames = ["Electronics", "CVC"]
    let companyDescription = ["This is an electronics shop","CVC is a non profit organization"]
    let companyPhotos = ["electronics","CVC"]
    let companyPhoneNo = ["9871434245","8712312360"]
    
    @IBAction func goToDonate(_ sender: Any) {
        performSegue(withIdentifier: "donateTo", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrapTableView.delegate = self
        scrapTableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = scrapTableView.dequeueReusableCell(withIdentifier: "waste", for: indexPath) as! CompanyTableViewCell
        
        cell.company_name.text = companyNames[indexPath.row]
        cell.company_image.image = UIImage(imageLiteralResourceName: companyPhotos[indexPath.row])
        cell.company_description.text = companyDescription[indexPath.row]
        cell.company_phone_number.text = companyPhoneNo[indexPath.row]
        
        return cell
        
    }
    

}

//
//  ScrapViewController.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 05/05/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit
import Firebase


class ScrapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    


    var ref: DatabaseReference!
    var scrapList = [Organizations]()
    
    @IBOutlet var scrapTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        scrapTableView.delegate = self
        scrapTableView.dataSource = self
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return scrapList.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = scrapTableView.dequeueReusableCell(withIdentifier: "waste", for: indexPath) as! CompanyTableViewCell
        
        let scraps_list = scrapList[indexPath.row]
        cell.company_name.text = scraps_list.name
        cell.company_description.text = scraps_list.desc
        cell.company_phone_number.text = scraps_list.number
        cell.donateButton.layer.shadowOpacity = 0.15
        cell.donateButton.layer.shadowRadius = 1
        cell.donateButton.layer.shadowColor = UIColor.black.cgColor
        cell.donateButton.layer.cornerRadius = 1
        
        cell.company_image.layer.shadowColor = UIColor.black.cgColor
        cell.company_image.layer.cornerRadius = 1
        cell.company_image.layer.masksToBounds = false
        cell.company_image.layer.shadowOpacity = 0.3
        cell.company_image.layer.shadowOffset = CGSize(width: -1.5, height: 1.5)
        cell.company_image.layer.shadowRadius = 2
        cell.company_image.layer.shouldRasterize = true
        
        if let organizationImageUrl = URL(string: scraps_list.image!){
            print(organizationImageUrl)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: organizationImageUrl)
                if let data = data {
                    let final_image = UIImage(data: data)
                    DispatchQueue.main.async { cell.company_image.image = final_image }
                }
            }
        }
        return cell
    }
    
    func fetchData(){
        ref = Database.database().reference().child("Organization")
        ref?.observe(.childAdded, with: { (snapshot) in
            if let dictionary  = snapshot.value as? NSDictionary{
                let all_scraps = Organizations()
                
                let name = dictionary["name"] as? String ?? "Not found"
                let number = dictionary["number"] as? String ?? "Not found"
                let description = dictionary["desc"] as? String ?? "Not found"
                let image = dictionary["image"] as? String ?? "Not found"
                
                all_scraps.name = name
                all_scraps.desc = description
                all_scraps.number = number
                all_scraps.image = image
                
                self.scrapList.append(all_scraps)
                
                DispatchQueue.main.async { self.scrapTableView.reloadData() }
            }
        })
    }
    

}

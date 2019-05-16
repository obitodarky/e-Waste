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
    let companyInfo:[String:String] = ["Electronics": "electronics"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = scrapTableView.dequeueReusableCell(withIdentifier: "waste", for: indexPath)
        
        cell.textLabel?.text = "\(companyInfo)"
        return cell
        
    }
    

}

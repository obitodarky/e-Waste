//
//  WasteTypeViewController.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 24/03/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit
import FirebaseDatabase



class WasteTypeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate , UISearchBarDelegate, UISearchDisplayDelegate {
    
    var wasteData = [Waste]()
    var wasteSearchArray = [String]()
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle?
    var searchItemArray = [String]()
    var searching = false
    
    var waste_name: String!
    var waste_image: String!
    var waste_desc: String!
    var waste_type: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate  = self
        tableView.dataSource = self
        
        fetchUser()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searching){ return wasteData.count }
        else{ return wasteData.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "waste_type", for: indexPath) as! WasteDescriptionTableViewCell
        
        if (searching){
            cell.wasteName.text = searchItemArray[indexPath.row]
            cell.wasteImage.image = UIImage(imageLiteralResourceName: "vegetable")
        } else {
            do{
                    let wastes = wasteData[indexPath.row]
                    cell.wasteName.text = wastes.name
                    wasteSearchArray.append(wastes.name!)
                    wasteSearchArray.sort()
                if let wasteImageUrl = URL(string: wastes.waste_image!){
                    print(wasteImageUrl)
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: wasteImageUrl)
                        if let data = data {
                            let final_image = UIImage(data: data)
                            DispatchQueue.main.async { cell.wasteImage.image = final_image }
                        }
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let wastes = wasteData[indexPath.row]
        waste_name = wastes.name
        waste_image = wastes.waste_image
        waste_desc = wastes.waste_description
        waste_type = wastes.waste_type
        performSegue(withIdentifier: "wasteSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "wasteSegue"){
            
            let vc = segue.destination as! WasteDescriptionViewController
            vc.wasteDescription!.text = waste_desc
            vc.wasteName!.text = waste_name
            
        }
    }
    
    func fetchUser(){
        ref = Database.database().reference().child("Items")
        ref?.observe(.childAdded, with: { (snapshot) in

            if let dictonary = snapshot.value as? NSDictionary{
                let waste = Waste()
                
                let name = dictonary["name"] as? String ?? "Not found"
                let description = dictonary["waste_description"] as? String ?? "Not found"
                let type = dictonary["waste_type"] as? String ?? "Not found"
                let image = dictonary["waste_image"] as? String ?? "Not found"
                
                waste.name = name
                waste.waste_description = description
                waste.waste_type = type
                waste.waste_image = image
                self.wasteData.append(waste)
                DispatchQueue.main.async { self.tableView.reloadData() }
            }
        })
    }
}



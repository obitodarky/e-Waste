//
//  WasteTypeViewController.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 24/03/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit
import FirebaseDatabase



class WasteTypeViewController: ViewController,UITableViewDataSource,UITableViewDelegate , UISearchBarDelegate, UISearchDisplayDelegate {

    //MARK: variables and outlets
    var wasteArray = ["Vegetable Peels", "Mop Stick", "Mosquito Repellent Refill Bottles" ,"Fruit Peels", "Used Mop Cloth", "Mosquito Repellent Mats", "Rotten Vegetables","Toilet Cleaning Brush","Used Odonil","Rotten Fruits","Brush and Scrubs for Cleaning", "Expired Medicines or Medicine Bottles","Left Over Food ","Soap Covers","Used Syringes","Mango Seeds","Chocolate Wrappers","Diapers and sanitary pads","Used Tea Bags","Butter Paper","Injection Bottles","Used Coffee Powder from Filter","Milk Covers","Compact Fluorescent Light(CFL)","Egg Shells","Ghee/Oil Packets","Used Cooking oil","Rotten Eggs","Oil Cans","Bottles or cans of Mosquito Sprays","Coconut Shells","Newspaper","Fluorescent","Tender Coconut Shells","Used paper Pieces","Button Cells","Used Leaves and Flowers","Old Posts","Hospital waste","Spoiled Spices","Broken Stationary","Bottles or cans of Insecticide Sprays","Floor Sweeping Dust","Used Razor Blades","Thermometers","Meat and Non-Veg Remains","Empty Shampoo Bottle","Batteries","Bones","Empty Perfume Bottle","Used Condoms","Left Over Pet Food","Thermocol","Chemical container of appliances","Garden Leaves","Broken Glass","Used Cotton and Bandage","Dried Flowers","Plastic Items","Sterile gauge","Weed","Aluminum Cans","Motor Oil","Bread Crusts","Aluminum Foils","Cell Phones"]
    
    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle?
    var searchItemArray = [String]()
    var wasteData = [String]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wasteArray.sort()
        
        tableView.delegate  = self
        tableView.dataSource = self
        
        ref = Database.database().reference()
        ref?.child("Waste").observeSingleEvent(of: .value, with: { (snapshot) in
                self.tableView.reloadData()
        })
    }
    //MARK: table functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searching){
            return searchItemArray.count
        }
        else{
            return wasteArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "waste_type", for: indexPath) as! WasteDescriptionTableViewCell
        
        if (searching){
            cell.wasteName.text = searchItemArray[indexPath.row]
        } else {
            cell.wasteName.text = wasteArray[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "wasteSegue", sender: self)
    }
    
    //MARK: search functions
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchItemArray = wasteArray.filter({
            $0.lowercased().prefix(searchText.count) == searchText.lowercased()
        })
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        searchBar.endEditing(true)
        tableView.reloadData()
    }
    func showSearchBar() {
        searchBar.alpha = 0
        navigationItem.titleView = searchBar
        navigationItem.setLeftBarButton(nil, animated: true)
        UIView.animate(withDuration: 0.5, animations: {
            self.searchBar.alpha = 1
        }, completion: { finished in
            self.searchBar.becomeFirstResponder()
        })
    }
    
    /*func hideSearchBar() {
        navigationItem.setLeftBarButtonItem(searchBarButtonItem, animated: true)
        logoImageView.alpha = 0
        UIView.animateWithDuration(0.3, animations: {
            self.navigationItem.titleView = self.logoImageView
            self.logoImageView.alpha = 1
        }, completion: { finished in
            
        })
    }*/
    
}



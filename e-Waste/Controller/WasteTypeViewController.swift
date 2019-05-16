//
//  WasteTypeViewController.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 24/03/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit

let wasteArray = ["Vegetable Peels ", "Mop Stick ", "Mosquito Repellent Refill Bottles " ,"Fruit Peels ", "Used Mop Cloth ", "Mosquito Repellent Mats ", "Rotten Vegetables ","Toilet Cleaning Brush ","Used Odonil","Rotten Fruits    ","Brush and Scrubs for Cleaning", "Expired Medicines or Medicine Bottles","Left Over Food ","Soap Covers ","Used Syringes","Mango Seeds  ","Chocolate Wrappers ","Diapers and sanitary pads","Used Tea Bags ","Butter Paper ","Injection Bottles","Used Coffee Powder from Filter ","Milk Covers ","Compact Fluorescent Light(CFL)","Egg Shells ","Ghee/Oil Packets ","Used Cooking oil","Rotten Eggs ","Oil Cans ","Bottles or cans of Mosquito Sprays","Coconut Shells ","Newspaper ","Fluorescent","Tender Coconut Shells    ","Used paper Pieces ","Button Cells","Used Leaves and Flowers  ","Old Posts ","Hospital waste ","Spoiled Spices ","Broken Stationary ","Bottles or cans of Insecticide Sprays","Floor Sweeping Dust ","Used Razor Blades ","Thermometers","Meat and Non-Veg Remains ","Empty Shampoo Bottle  ","Batteries","Bones","Empty Perfume Bottle","Used Condoms","Left Over Pet Food  ","Thermocol","Chemical container of appliances","Garden Leaves","Broken Glass  ","Used Cotton and Bandage","Dried Flowers  ","Plastic Items  ","Sterile gauge","Weed  ","Aluminum Cans  ","Motor Oil","Bread Crusts  ","Aluminum Foils  ","Cell Phones"]

var final_index = 0

class WasteTypeViewController: ViewController,UITableViewDataSource,UITableViewDelegate , UISearchBarDelegate, UISearchDisplayDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wasteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "waste_type", for: indexPath)
        
        cell.textLabel?.text = wasteArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        final_index = indexPath.row
        performSegue(withIdentifier: "wasteSegue", sender: self)
        
    }
    
    
    
    
}

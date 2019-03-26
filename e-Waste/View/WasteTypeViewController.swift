//
//  WasteTypeViewController.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 24/03/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit

class WasteTypeViewController: ViewController,UITableViewDataSource,UITableViewDelegate , UISearchBarDelegate, UISearchDisplayDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    let wasteArray = ["1. Vegetable Peels ", "1. Mop Stick ", "1. Mosquito Repellent Refill " ,"Bottles Fruit Peels ", "Used Mop Cloth ", "Mosquito Repellent Mats ", "3. Rotten Vegetables ","3. Toilet Cleaning Brush ","3. Used Odonil","4. Rotten Fruits    ","4. Brush and Scrubs for Cleaning", "4. Expired Medicines or Medicine Bottles","5. Left Over Food ","5. Soap Covers ","5. Used Syringes","6. Mango Seeds  ","6. Chocolate Wrappers ","6. Diapers and sanitary pads","7. Used Tea Bags ","7. Butter Paper ","7. Injection Bottles","8. Used Coffee Powder from Filter ","8. Milk Covers ","8. Compact Fluorescent Light(CFL)","9. Egg Shells ","9. Ghee/Oil Packets ","9. Used Cooking oil","10. Rotten Eggs ","10. Oil Cans ","10. Bottles or cans of Mosquito Sprays","11. Coconut Shells ","11. Newspaper ","11. Fluorescent","12. Tender Coconut Shells    ","12. Used paper Pieces ","12. Button Cells","13. Used Leaves and Flowers  ","  13. Old Posts ","13. Hospital waste ","14. Spoiled Spices ","14. Broken Stationary ","14. Bottles or cans of Insecticide Sprays","15. Floor Sweeping Dust ","15.Used Razor Blades ","15. Thermometers","16. Meat and Non-Veg Remains ","16. Empty Shampoo Bottle  ","16. Batteries","17. Bones","17. Empty Perfume Bottle","17. Used Condoms","18. Left Over Pet Food  ","18. Thermocol","18. Chemical container of appliances","19. Garden Leaves","19. Broken Glass  ","19. Used Cotton and Bandage","20. Dried Flowers  ","20. Plastic Items  ","20. Sterile gauge","21. Weed  ","21. Aluminum Cans  ","21. Motor Oil","22. Bread Crusts  ","22. Aluminum Foils  ","22. Cell Phones"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wasteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = wasteArray[indexPath.row]
        
        return cell
    }
    
    
}

//
//  WasteDataViewController.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 01/06/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit
import Firebase

class WasteDataViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {


    @IBOutlet var wasteCollectionView: UICollectionView!
    
    var wasteData = [Waste]()
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        let layout = wasteCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.sectionInset = UIEdgeInsets(top: 5, left: 7, bottom: 5, right: 7)
        layout.minimumInteritemSpacing = 5


    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return wasteData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = wasteCollectionView.dequeueReusableCell(withReuseIdentifier: "waste_col", for: indexPath) as! WasteCollectionViewCell
        
        let wastes = wasteData[indexPath.row]
        cell.wasteName.text = wastes.name
        cell.wasteType.text = "(\(String(wastes.waste_type)))"
        cell.wasteDescription.text = wastes.waste_description

        cell.wasteImage.layer.shadowColor = UIColor.black.cgColor
        cell.wasteImage.layer.cornerRadius = 1
        cell.wasteImage.layer.masksToBounds = false
        cell.wasteImage.layer.shadowOpacity = 0.3
        cell.wasteImage.layer.shadowOffset = CGSize(width: -1.5, height: 1.5)
        cell.wasteImage.layer.shadowRadius = 2
        cell.wasteImage.layer.shouldRasterize = true
        
        if let wasteImageUrl = URL(string: wastes.waste_image!){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: wasteImageUrl)
                if let data = data {
                    let final_image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.wasteImage.image = final_image
    

                    }
                }
            }
        }
        
        return cell
       
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
                DispatchQueue.main.async { self.wasteCollectionView.reloadData() }
            }
        })
    }
    
}

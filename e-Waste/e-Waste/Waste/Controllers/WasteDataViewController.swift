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



    @IBOutlet var gradientView: UIViewX!
    @IBOutlet var wasteCollectionView: UICollectionView!
    
    var colorArrayIndex = -1
    
    var colorArray: [(color1: UIColor, color2: UIColor)] = []
    
    var wasteData = [Waste]()
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        
        colorArray.append((color1: #colorLiteral(red: 0.5033842325, green: 0.8740338683, blue: 0.6319764256, alpha: 0.8470588235), color2: #colorLiteral(red: 0.3411764801, green: 0.8529547339, blue: 0.4490480466, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.3411764801, green: 0.8529547339, blue: 0.4490480466, alpha: 1), color2: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), color2: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), color2: #colorLiteral(red: 0.2392156869, green: 0.8018642754, blue: 0.9686274529, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.2392156869, green: 0.8018642754, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), color2: #colorLiteral(red: 0.4044704911, green: 0.8740338683, blue: 1, alpha: 0.8470588235)))
        colorArray.append((color1: #colorLiteral(red: 0.4044704911, green: 0.8740338683, blue: 1, alpha: 0.8470588235), color2: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), color2: #colorLiteral(red: 0.4164567924, green: 0.8740338683, blue: 0.4390986431, alpha: 0.8470588235)))
        
        
        let layout = wasteCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 5, left: 7, bottom: 5, right: 7)
        layout.minimumInteritemSpacing = 5
        animateBackgroundColor()

    }
    func animateBackgroundColor(){
        //colorArrayIndex = colorArrayIndex == (colorArray.count -1) ? 0 : colorArrayIndex + 1
        if(colorArrayIndex == colorArray.count - 1){
            colorArrayIndex = 0
        } else {
            colorArrayIndex += 1
        }
        
        UIView.transition(with: gradientView, duration: 2, options: [.transitionCrossDissolve], animations: {
            self.gradientView.firstColor = self.colorArray[self.colorArrayIndex].color1
            self.gradientView.secondColor = self.colorArray[self.colorArrayIndex].color2
        }) { (sucess) in
            self.animateBackgroundColor()
        }
        
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

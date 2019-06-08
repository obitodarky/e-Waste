//
//  CompanyViewController.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 08/06/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit
import Firebase

class CompanyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    

    @IBOutlet var gradientView: UIViewX!
    @IBOutlet var companyCollectionView: UICollectionView!
    var colorArray: [(color1: UIColor,color2: UIColor)] = []
    
    var colorArrayIndex = -1
    
    var ref: DatabaseReference!
    var scrapList = [Organizations]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        colorArray.append((color1: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), color2: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), color2: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), color2: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), color2: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), color2: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), color2: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), color2: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), color2: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
        
        
        let layout = companyCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 5, left: 7, bottom: 5, right: 7)
        layout.minimumInteritemSpacing = 5
        animateBackgroundColor()
        
    }
    
    func animateBackgroundColor(){
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
        return scrapList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = companyCollectionView.dequeueReusableCell(withReuseIdentifier: "comp_cell", for: indexPath) as! CompanyCollectionViewCell
        
        let scraps_list = scrapList[indexPath.row]
        cell.companyName.text = scraps_list.name
        cell.companyDescripttion.text = scraps_list.desc
        cell.companyNumber.text = scraps_list.number
        /*cell.donateButton.layer.shadowOpacity = 0.15
        cell.donateButton.layer.shadowRadius = 1
        cell.donateButton.layer.shadowColor = UIColor.black.cgColor
        cell.donateButton.layer.cornerRadius = 1 */
        
        cell.companyImage.layer.shadowColor = UIColor.black.cgColor
        cell.companyImage.layer.cornerRadius = 1
        cell.companyImage.layer.masksToBounds = false
        cell.companyImage.layer.shadowOpacity = 0.3
        cell.companyImage.layer.shadowOffset = CGSize(width: -1.5, height: 1.5)
        cell.companyImage.layer.shadowRadius = 2
        cell.companyImage.layer.shouldRasterize = true
        
        if let organizationImageUrl = URL(string: scraps_list.image!){
            print(organizationImageUrl)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: organizationImageUrl)
                if let data = data {
                    let final_image = UIImage(data: data)
                    DispatchQueue.main.async { cell.companyImage.image = final_image }
                }
            }
        }
        
        return cell
    }

}

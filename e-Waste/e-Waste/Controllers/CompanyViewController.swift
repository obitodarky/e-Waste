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
    var colorArray: [(color1: UIColor, color2: UIColor)] = []
    var colorArrayIndex = -1
    var ref: DatabaseReference!
    var scrapList = [Organizations]()


    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        colorArray.append((color1: #colorLiteral(red: 0.5033842325, green: 0.8740338683, blue: 0.6319764256, alpha: 0.8470588235), color2: #colorLiteral(red: 0.3411764801, green: 0.8529547339, blue: 0.4490480466, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.3411764801, green: 0.8529547339, blue: 0.4490480466, alpha: 1), color2: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), color2: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), color2: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), color2: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), color2: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), color2: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
        let layout = companyCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 5, left: 7, bottom: 5, right: 7)
        layout.minimumInteritemSpacing = 5
        animateBackgroundColor()
    }
    
    @IBAction func donatePressed(_ sender: Any) {
        let alert = UIAlertController(title: "Donate", message: "Bank ID: " + scrapList[0].account!, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true)
    }
    func animateBackgroundColor() {
        if colorArrayIndex == colorArray.count - 1 {
            colorArrayIndex = 0
        } else {
            colorArrayIndex += 1
        }
        UIView.transition(with: gradientView, duration: 2, options: [.transitionCrossDissolve], animations: {
            self.gradientView.firstColor = self.colorArray[self.colorArrayIndex].color1
            self.gradientView.secondColor = self.colorArray[self.colorArrayIndex].color2
        }) { sucess in
            self.animateBackgroundColor()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scrapList.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = companyCollectionView.dequeueReusableCell(withReuseIdentifier: "comp_cell", for: indexPath) as! CompanyCollectionViewCell
        let scraps_list = scrapList[indexPath.row]
        cell.companyName.text = scraps_list.name
        cell.companyDescripttion.text = scraps_list.desc
        cell.companyNumber.text = scraps_list.number
        cell.companyAddress.text = scraps_list.address
        cell.bankDetails = scraps_list.account
        cell.donateButton.layer.shadowOpacity = 0.15
        cell.donateButton.layer.shadowRadius = 1
        cell.donateButton.layer.shadowColor = UIColor.black.cgColor
        cell.donateButton.layer.cornerRadius = 1
        cell.companyImage.layer.shadowColor = UIColor.black.cgColor
        cell.companyImage.layer.cornerRadius = 1
        cell.companyImage.layer.masksToBounds = false
        cell.companyImage.layer.shadowOpacity = 0.3
        cell.companyImage.layer.shadowOffset = CGSize(width: -1.5, height: 1.5)
        cell.companyImage.layer.shadowRadius = 2
        cell.companyImage.layer.shouldRasterize = true
        
        
        if let organizationImageUrl = URL(string: scraps_list.image!) {
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
    func fetchData() {
        ref = Database.database().reference().child("Organization")
        ref?.observe(.childAdded, with: { (snapshot) in
            if let dictionary  = snapshot.value as? NSDictionary {
                let all_scraps = Organizations()
                let name = dictionary["name"] as? String ?? "Not found"
                let number = dictionary["number"] as? String ?? "Not found"
                let description = dictionary["desc"] as? String ?? "Not found"
                let image = dictionary["image"] as? String ?? "Not found"
                let address = dictionary["address"] as? String ?? "Not Found"
                let account = dictionary["account"] as? String ?? "Not found"
                all_scraps.address = address
                all_scraps.account = account
                all_scraps.name = name
                all_scraps.desc = description
                all_scraps.number = number
                all_scraps.image = image
                self.scrapList.append(all_scraps)
                DispatchQueue.main.async { self.companyCollectionView.reloadData() }
            }
        })
    }
}

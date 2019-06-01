//
//  WasteDataViewController.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 01/06/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit

class WasteDataViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {


    @IBOutlet var wasteCollectionView: UICollectionView!
    
    var wasteData = [Waste]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return wasteData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = wasteCollectionView.dequeueReusableCell(withReuseIdentifier: "waste_col", for: indexPath) as! WasteCollectionViewCell
        
        return cell
       
    }
    
}

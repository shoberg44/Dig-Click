//
//  MarketViewController.swift
//  Dig Click
//
//  Created by STEVEN HOBERG on 3/15/23.
//

import UIKit
class MarketViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = self
    }
    
    @IBAction func sellButton(_ sender: UIButton) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Public.inventory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sellCell", for: indexPath) as! MarketCell
        
        cell.configure(name: Public.inventory[indexPath.row].name, value: Public.inventory[indexPath.row].value, icon: Public.inventory[indexPath.row].picture)
        return cell
    }
}

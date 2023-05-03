//
//  InventoryViewController.swift
//  Dig Click
//
//  Created by STEVEN HOBERG on 2/13/23.
//

import UIKit

class InventoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    @IBOutlet weak var infoTabView: UIView!
    
    @IBOutlet weak var tabName: UILabel!
    
    var previousSelection: IndexPath? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = self
        collectionViewOutlet.reloadData()
        infoTabView.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Public.inventory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! InventoryCell
        cell.configure(name: Public.inventory[indexPath.row].name, value: Public.inventory[indexPath.row].value, icon: Public.inventory[indexPath.row].picture)
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! InventoryCell
//
//        cell.backgroundColor = UIColor.clear
//        infoTabView.isHidden = true
//    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! InventoryCell
        if let i = previousSelection{
            collectionViewOutlet.deselectItem(at: i, animated: true)
            collectionViewOutlet.cellForItem(at: i)?.backgroundColor = UIColor.clear
            print("selection replacement at \(i)")
            previousSelection = indexPath
        }
        else{
            print("first time selection")
            previousSelection = indexPath
        }
        cell.backgroundColor = UIColor.tintColor
        
        infoTabPopulate(item: Public.inventory[indexPath[1]])
        infoTabView.isHidden = false
    }
    func infoTabPopulate(item: Drop){
        tabName.text = ("\(item.name) \(item.type.rawValue)")
    }
    

}

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
    
    var highlighted: [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = self
        collectionViewOutlet.reloadData()
        infoTabView.isHidden = true
        highlighted = []
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Public.inventory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! InventoryCell
        cell.configure(name: Public.inventory[indexPath.row].name, value: Public.inventory[indexPath.row].value, icon: Public.inventory[indexPath.row].picture, UUID: Public.inventory[indexPath.row].UUID)
        //every cell takes on the dynammicly generated UUID of its corrisponding drop. On state change or redraw it now rehighlights or unhighlights based of its in the "highlighted" list.
        
        if highlighted.contains(where: { x in
            cell.inventoryUUID == x
        }){
            cell.backgroundColor = UIColor(named: "DigGreen")
        }
        else{
            cell.backgroundColor = UIColor.clear
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! InventoryCell
        cell.backgroundColor = UIColor.clear
        highlighted.removeAll { x in
            cell.inventoryUUID == x
        }
        if highlighted.count <= 2{
            infoTabView.isHidden = false
        }
        else{
            infoTabView.isHidden = true
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! InventoryCell
        highlighted.append(cell.inventoryUUID)
        cell.backgroundColor = UIColor(named: "DigGreen")
        infoTabPopulate(item: Public.inventory[indexPath[1]])
        if highlighted.count <= 2{
            infoTabView.isHidden = false
        }
        else{
            infoTabView.isHidden = true
        }
        print("length-> \(highlighted.count)")
    }
    func infoTabPopulate(item: Drop){
        tabName.text = ("\(item.name) \(item.type.rawValue)")
    }
    

}

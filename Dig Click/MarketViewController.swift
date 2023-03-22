//
//  MarketViewController.swift
//  Dig Click
//
//  Created by STEVEN HOBERG on 3/15/23.
//

import UIKit
class MarketViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    let formatter = NumberFormatter()
    var selectedIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.numberStyle = .currency
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = self
        collectionViewOutlet.allowsMultipleSelection = true
        if let formattedTipAmount = formatter.string(from: Public.money as NSNumber) {
            costLabel.text = "\(formattedTipAmount)"
        }
    }
    
    @IBAction func sellAllButton(_ sender: UIButton) {
        for i in 0..<Public.inventory.count{
            
            var e = collectionViewOutlet.cellForItem(at: [0,i]) as! MarketCell
            e.isSelectedC = true
            e.isSelected = true
        }
        
        collectionViewOutlet.reloadData()
        //interpretSellArray(sellArray: newArray)
    }
    @IBAction func sellButton(_ sender: UIButton) {
        var newArray: [Int] = []
        var selectedItems = collectionViewOutlet.indexPathsForSelectedItems
        if selectedItems != nil {
            for i in selectedItems!{
                newArray.append(i[1])
            }
            newArray = newArray.sorted()
            
            newArray = newArray.reversed()
            interpretSellArray(sellArray: newArray)
        }
        else {
          print("empty")
        }
        
        
    }
    func interpretSellArray(sellArray: [Int]){
        for i in sellArray{
            
            Public.money += Public.inventory[i].value
            Public.inventory.remove(at: i)

        }
        collectionViewOutlet.deleteItems(at: collectionViewOutlet.indexPathsForSelectedItems!)
        if let formattedTipAmount = formatter.string(from: Public.money as NSNumber) {
            costLabel.text = "\(formattedTipAmount)"
        }
        collectionViewOutlet.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Public.inventory.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sellCell", for: indexPath) as! MarketCell
        
        cell.configure(name: Public.inventory[indexPath.row].name, value: Public.inventory[indexPath.row].value, icon: Public.inventory[indexPath.row].picture)
        print(cell.isSelectedC)
        if cell.isSelectedC{
            
            cell.backgroundColor = UIColor.tintColor
            cell.isSelected = true
        }
        else{
            cell.backgroundColor = UIColor.clear
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MarketCell
        cell.backgroundColor = UIColor.tintColor
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MarketCell
        cell.backgroundColor = UIColor.clear
    }
    
}

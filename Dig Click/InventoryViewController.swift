//
//  InventoryViewController.swift
//  Dig Click
//
//  Created by STEVEN HOBERG on 2/13/23.
//

import UIKit

class InventoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var tabWeight: UILabel!
    @IBOutlet weak var meltTitle: UILabel!
    @IBOutlet weak var moneyOutlet: UILabel!
    @IBOutlet weak var meltGrade: UILabel!
    
    @IBOutlet weak var meltValue: UILabel!
    @IBOutlet weak var meltView: UIView!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    @IBOutlet weak var rarityOpenButton: UIButton!
    @IBOutlet weak var infoTabView: UIView!
    @IBOutlet weak var tabGrade: UILabel!
    
    @IBOutlet weak var tabSellLabel: UILabel!
    @IBOutlet weak var tabName: UILabel!
    let COMPARECONSTANTMAX: Int = 2
    var highlighted: [Int] = []
    let formatter = NumberFormatter()
    var selectedCell: InventoryCell?
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.numberStyle = .currency
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = self
        collectionViewOutlet.reloadData()
        infoTabView.isHidden = true
        collectionViewOutlet.allowsMultipleSelection = true
        highlighted = []
        updateMoney()
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
            if Public.inventory[indexPath.row].pinned{
                cell.backgroundColor = UIColor.cyan
            }
        }
        else{
            cell.backgroundColor = UIColor.clear
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! InventoryCell
        cell.backgroundColor = UIColor(named: "DigGreen")
        if Public.inventory[indexPath.row].pinned{
            cell.backgroundColor = UIColor.cyan
        }
        highlighted.append(cell.inventoryUUID)
        selectedCell = collectionViewOutlet.cellForItem(at: indexPath) as! InventoryCell
        //info tab stuff
        
        if (highlighted.count <= COMPARECONSTANTMAX)&&(highlighted.count > 0){
            infoTabView.isHidden = false
            infoTabPopulate(item: Public.inventory[indexPath[1]])
        }
        else{
            print("too many")
            infoTabView.isHidden = true
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! InventoryCell
        cell.backgroundColor = UIColor.clear
        highlighted.removeAll { m in
            m == cell.inventoryUUID
        }
        
        //info tab stuff
        if (highlighted.count <= COMPARECONSTANTMAX)&&(highlighted.count > 0){
            infoTabView.isHidden = false
            infoTabPopulate(item: Drop.findDrop(targetUUID: highlighted[0]))
        }
        else{
            infoTabView.isHidden = true
        }
    }
    func infoTabPopulate(item: Drop){
        print(item.type)
        var canCombine: Bool = false
        
        if highlighted.count > 1{//determans meltiblity and prepares it if its needed
            let baseType: String = Drop.findDrop(targetUUID: highlighted[1]).type.rawValue
            
            var meltingDrop: Drop = Drop.findDrop(targetUUID: highlighted[0])
            if (meltingDrop.type.rawValue == baseType){
                if meltingDrop.meltable && item.meltable{
                    canCombine = true
                    print("meltable set")
                }
            }
            if canCombine{
                meltView.isHidden = false
                meltGrade.text = ("\(meltingDrop.grade)")
                meltTitle.text = ("Combing With \(meltingDrop.name)")
                meltValue.text = ("Value: \((floor(1000*meltingDrop.value)/1000))")
            }
            else{
                infoTabView.isHidden = true
            }
        }
        if !canCombine{
            meltView.isHidden = true
        }
        if (item.type.rawValue == "rarity")&&(highlighted.count == 1){
            rarityOpenButton.isHidden = false
            print("can open!")
        }
        else{
            rarityOpenButton.isHidden = true
        }
        
        tabName.text = ("\(item.type.rawValue)")
        tabGrade.text = ("Grade: \(item.grade)")
        tabSellLabel.text = ("Value: \((floor(1000*item.value)/1000))")
        tabWeight.text = ("Weight: \(item.weight)")
    }
    

    @IBAction func meltButton(_ sender: UIButton) {
        var melt1 = Drop.findDrop(targetUUID: highlighted[0])
        var melt2 = Drop.findDrop(targetUUID: highlighted[1])
        //print("melt1: \(melt1.grade) | melt2: \(melt2.grade)")
        var newGrade = melt1.grade + melt2.grade
        newGrade /= 2
        //print("here -> \(melt1.gradeValueScale)")
        var newDrop = Drop(value: melt1.value, picture: melt1.picture, meltable: true, weight: (melt1.weight+melt2.weight), type: melt1.type, isOre: melt1.isOre, canSell: melt1.canSell, name: melt1.name, grade: newGrade, gradeValueScale: melt1.gradeValueScale, pinned: false)
        newDrop.gradeAdjustValue(scale: newDrop.gradeValueScale)
        
        Public.inventory.removeAll { f in
            f.UUID == melt1.UUID
        }
        Public.inventory.removeAll { f in
            f.UUID == melt2.UUID
        }
        highlighted.removeFirst(2)
        
        print("\(newDrop.name) is new!")
        Public.inventory.append(newDrop)
        
        infoTabView.isHidden = true
        
        collectionViewOutlet.reloadData()
    }
    @IBAction func openButton(_ sender: UIButton) {
        let rand = Int.random(in: 1...2)
        switch rand {
        case 1://money
            let newMoney = Double(Loot(type: .money).money)
            Public.money += newMoney
            print("More Money! \(newMoney) additional $")
            
        default://drop
            let newDrop = Loot(type: .drop).drop
            Public.inventory.append(newDrop)
            print("New Drop! \(newDrop.name)")
        }
        Public.inventory.removeAll { c in
            c.UUID == highlighted[0]
        }
        highlighted.removeAll()
        if Public.inventory.count != 0{
            collectionViewOutlet.scrollToItem(at: [0,0], at: .top, animated: true)
        }
        infoTabView.isHidden = true
        save()
        updateMoney()
        highlighted.removeAll()
        collectionViewOutlet.reloadData()
    }
    func updateMoney(){
        if let formattedTipAmount = formatter.string(from: Public.money as NSNumber) {
            moneyOutlet.text = "\(formattedTipAmount)"
        }
    }
    @IBAction func pinButton(_ sender: UIButton) {
        var current: Drop = Drop(type: .unknown)
        if highlighted.count == 2{
            current = Drop.findDrop(targetUUID: highlighted[1])
        }
        else if highlighted.count == 1{
            current = Drop.findDrop(targetUUID: highlighted[0])
        }
        
        if current.pinned{
            current.pinned = false
            selectedCell?.backgroundColor = UIColor(named: "DigGreen")
        }
        else{
            current.pinned = true
            selectedCell?.backgroundColor = UIColor.cyan
        }
        
    }
    func save(){
        print("saved money | inventory")
        Public.defaults.set(Public.money, forKey: "money")
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(Public.inventory)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "inventory")

        } catch {
            print("Unable to Encode inventory (\(error))")
        }
    }
}

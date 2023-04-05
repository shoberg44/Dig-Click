//
//  ViewController.swift
//  Dig Click
//
//  Created by STEVEN HOBERG on 2/7/23.
//

import UIKit
class Public{
    static var money: Double = 0
    static var inventory: [Drop] = []
    static var pickaxe: Pickaxe = Pickaxe(type: .wood)
    static let iconSize = 80
    static var purchasedPickaxes: [Pickaxe] = [pickaxe]
    static var defaults = UserDefaults.standard
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Public.purchasedPickaxes.append(Public.pickaxe)
        Public.purchasedPickaxes = Public.defaults.object(forKey: "pickaxes")
        Public.money += 2000
        for i in 0...10{
            Public.inventory.append(Drop(type: .diamond))
        }
    }
    

}


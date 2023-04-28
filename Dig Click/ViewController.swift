//
//  ViewController.swift
//  Dig Click
//
//  Created by STEVEN HOBERG on 2/7/23.
//

import UIKit
import CoreData
class Public{
    static var money: Double = 0
    static var inventory: [Drop] = []
    static var pickaxe: Pickaxe = Pickaxe(type: .wood)
    static let iconSize = 80
    static var purchasedPickaxes: [Pickaxe] = [pickaxe]
    static var defaults = UserDefaults.standard
    static var seed: UInt64 = UInt64(77)
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Public.purchasedPickaxes.append(Public.pickaxe)
        load()
        Public.money += 2000
        for _ in 0...10{
            Public.inventory.append(Drop(type: .diamond))
        }
        
    }
    func load(){
        print("loaded all")
        if let mov = Public.defaults.object(forKey: "money"){
            Public.money = mov as! Double
        }
        else{
            print("could not save money")
        }
        
        
        //https://cocoacasts.com/ud-5-how-to-store-a-custom-object-in-user-defaults-in-swift
        if let data = UserDefaults.standard.data(forKey: "pickaxe") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                Public.pickaxe = try decoder.decode(Pickaxe.self, from: data)

            } catch {
                print("Unable to Decode pickaxe (\(error))")
            }
        }
        if let data = UserDefaults.standard.data(forKey: "pickaxes") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                Public.purchasedPickaxes = try decoder.decode([Pickaxe].self, from: data)

            } catch {
                print("Unable to Decode purchased pickaxes (\(error))")
            }
        }
        if let data = UserDefaults.standard.data(forKey: "inventory") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                Public.inventory = try decoder.decode([Drop].self, from: data)

            } catch {
                print("Unable to Decode inventory (\(error))")
            }
        }
    }

}


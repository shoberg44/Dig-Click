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
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Public.purchasedPickaxes.append(Public.pickaxe)
        
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
                let note = try decoder.decode(Note.self, from: data)

            } catch {
                print("Unable to Decode Pickaxe (\(error))")
            }
        }
        
        
        
        
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(Public.purchasedPickaxes)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "pickaxes")

        } catch {
            print("Unable to Encode Note (\(error))")
        }
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(Public.pickaxe)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "pickaxe")

        } catch {
            print("Unable to Encode Note (\(error))")
        }
        Public.money += 2000
        for _ in 0...10{
            Public.inventory.append(Drop(type: .diamond))
        }
    }
    

}


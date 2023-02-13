//
//  InventoryViewController.swift
//  Dig Click
//
//  Created by STEVEN HOBERG on 2/13/23.
//

import UIKit

class InventoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableOutlet: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Public.inventory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = Public.inventory[indexPath.row].name

               return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableOutlet.delegate = self
        tableOutlet.dataSource = self
        Public.inventory.append(Drop(type: .pebble))
        tableOutlet.reloadData()
    }

}

//
//  MineView.swift
//  Dig Click
//
//  Created by STEVEN HOBERG on 2/9/23.
//

import UIKit
class Public{
    static var money: Double = 0
    
}
class MineView: UIViewController {

    @IBOutlet weak var moneyOutlet: UILabel!
    @IBOutlet weak var ore1Icon: UIImageView!
    @IBOutlet weak var pickIconOutlet: UIImageView!
    let PICKDEFAULT: CGPoint = CGPoint(x: 196.0, y: 738.3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pickPanGesture(_ sender: UIPanGestureRecognizer) {
        let loc = sender.location(in: view)
        pickIconOutlet.center = loc
        
        if (CGRectIntersectsRect(ore1Icon.frame, pickIconOutlet.frame)) {//detects collision
            Public.money += 0.5 //function runs twice on collision so this actuallhy adds to 1
            pickIconOutlet.center = PICKDEFAULT //resets posistion
            updateView()
            sender.state = .ended //ends drag
            
        }
    }
    func updateView(){
        //formats money
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: Public.money as NSNumber) {
            moneyOutlet.text = "\(formattedTipAmount)"
        }
        
        
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
    
    

}

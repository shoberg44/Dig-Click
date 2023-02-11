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
    
    @IBOutlet weak var dropIcon: UIImageView!
    @IBOutlet weak var moneyOutlet: UILabel!
    @IBOutlet weak var ore1Icon: UIImageView!
    @IBOutlet weak var pickIconOutlet: UIImageView!
    let PICKDEFAULT: CGPoint = CGPoint(x: 196.0, y: 738.3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropIcon.isHidden = true
        updateView()
    }
    
    @IBAction func pickPanGesture(_ sender: UIPanGestureRecognizer) {
        let loc = sender.location(in: view)
        pickIconOutlet.center = loc
        
        if (CGRectIntersectsRect(ore1Icon.frame, pickIconOutlet.frame)) {//detects collision
            Public.money += 0.5 //function runs twice on collision so this actuallhy adds to 1
            dropOre()
            
            pickIconOutlet.center = PICKDEFAULT //resets posistion
            updateView()//updates view (just score for now)
            
            
            sender.state = .ended //ends drag
            
        }
    }
    
    func dropOre(){
        dropIcon.center = ore1Icon.center
        dropIcon.isHidden = false
        var time = 0.0
        var first = false
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if !self.dropIcon.frame.contains(CGPoint(x: self.dropIcon.center.x, y: 800)){
                time += 0.05
                
                self.dropIcon.center.y += pow(time, 2)*16+100*time-4 //gravity
                //self.dropIcon.center.y += 10
            }
            else{
                timer.invalidate()
                self.dropIcon.isHidden = true
                
            }
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
        
}

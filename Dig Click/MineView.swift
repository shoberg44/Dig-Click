//
//  MineView.swift
//  Dig Click
//
//  Created by STEVEN HOBERG on 2/9/23.
//

import UIKit
class Public{
    static var money: Double = 0
    static var inventory: [Drop] = []
}
class MineView: UIViewController {
    
    @IBOutlet weak var dropIcon: UIImageView!
    @IBOutlet weak var moneyOutlet: UILabel!
    @IBOutlet weak var ore1Icon: UIImageView!
    @IBOutlet weak var pickIconOutlet: UIImageView!
    let PICKDEFAULT: CGPoint = CGPoint(x: 196.0, y: 738.3) //constant
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropIcon.isHidden = true
        StoneRock().breakEvent()
        updateView()
    }
    
    @IBAction func pickPanGesture(_ sender: UIPanGestureRecognizer) {
        let loc = sender.location(in: view)
        pickIconOutlet.center = loc
        
        if (CGRectIntersectsRect(ore1Icon.frame, pickIconOutlet.frame)) {//detects collision
            Public.money += 0.5 //function runs twice on collision so this actually adds to 1
            dropOre()//runs animation
            pickIconOutlet.center = PICKDEFAULT //resets posistion
            updateView()//updates view (just score for now)
            sender.state = .ended //ends drag
        }
    }
    
    func dropOre(){
        dropIcon.center = ore1Icon.center
        //dropIcon.image =
        dropIcon.isHidden = false
        var time = 0.0
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if !self.dropIcon.frame.contains(CGPoint(x: self.dropIcon.center.x, y: 780)){
                time += 0.05
                
                self.dropIcon.center.y += pow(time, 2)*16+100*time-4 //gravity
            }
            else{
                timer.invalidate()
                time = 0.5
                var iterations = 0
                Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer2 in
                    iterations += 1
                    
                    time = time - 0.07
                    self.dropIcon.center.y -= pow(time, 2)*16+100*time-4
                    if iterations >= 14{
                        self.dropIcon.isHidden = true
                        timer2.invalidate()
                    }
                }
                
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

//
//  DynamicAnimatorViewController.swift
//  ImageViewTransition
//
//  Created by Srijan on 07/11/17.
//  Copyright © 2017 Srijan. All rights reserved.
//

import UIKit



class DynamicAnimatorViewController: UIViewController {
    
    var animator : UIDynamicAnimator!
    var snapBehaviour : UISnapBehavior!
    
    var gravityBehaviour : UIGravityBehavior!
    var colllisionBehaviour : UICollisionBehavior!
    var bounceBehaviour : UIDynamicItemBehavior!
    
    var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        button = UIButton(frame: CGRect(x: 320, y: 220, width: 100, height: 40))
        button.center = self.view.center
        button.backgroundColor = UIColor.darkGray
        button.setTitle("CLick", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(self.tap), for: .touchUpInside)
        self.view.addSubview(button)
        
        
       
        
        // Do any additional setup after loading the view.
    }
    
    func tap() {
    animator = UIDynamicAnimator(referenceView: self.view)
    
    let point = CGPoint(x: 150, y: 150)
    
    snapBehaviour = UISnapBehavior(item: button, snapTo: point)
    snapBehaviour.damping = 0.2
    animator.addBehavior(snapBehaviour)
        
        
//    
//        gravityBehaviour = UIGravityBehavior(items: [button])
//        
//        animator.addBehavior(gravityBehaviour)
//        
//        
//        colllisionBehaviour = UICollisionBehavior(items: [button])
//        colllisionBehaviour.translatesReferenceBoundsIntoBoundary = true
//        animator.addBehavior(colllisionBehaviour)
//        
//        
//        bounceBehaviour = UIDynamicItemBehavior(items: [button])
//        bounceBehaviour.elasticity = 0.2
//        animator.addBehavior(bounceBehaviour)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

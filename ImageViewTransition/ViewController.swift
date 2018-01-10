//
//  ViewController.swift
//  ImageViewTransition
//
//  Created by Srijan on 02/11/17.
//  Copyright © 2017 Srijan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let transition = CircularTransition()
    let button = UIButton(type: .custom)
    
    
    let imageView = UIImageView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        imageView.frame = CGRect(x: 160, y: 100, width: 100, height: 100)
        imageView.center = self.view.center
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = UIColor.yellow
        self.view.addSubview(imageView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(thumbsUpButtonPressed))
        imageView.addGestureRecognizer(tapGesture)
        
        
    }
    
    func thumbsUpButtonPressed() {
        print("button pressed")
//        
//        let secondVC = SecondViewController()
//        let navController = UINavigationController(rootViewController: secondVC)
//        navController.transitioningDelegate = transition
//        
//        transition.circleColor = imageView.backgroundColor!
//        transition.startingPoint = imageView.center
//        
//        navController.modalPresentationStyle = .custom
//        self.present(navController, animated: true, completion: nil)
//        
        
        let pv = DraggableViewController()
        self.navigationController?.pushViewController(pv, animated: true)
        
    }
    
   
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIButton {
    func addAttribute() {
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
        self.setTitle("S", for: .normal)
        self.setTitleColor(UIColor.darkGray, for: .normal)
        self.backgroundColor = UIColor.yellow

    }
}


//
//  SecondViewController.swift
//  ImageViewTransition
//
//  Created by Srijan on 02/11/17.
//  Copyright © 2017 Srijan. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var bgColor = UIColor.black

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.purple
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.backgroundColor = bgColor
        
        let cancelButton = UIButton(frame: CGRect(x: 10, y: 20, width: 50, height: 50))
        cancelButton.addTarget(self, action: #selector(self.dismissView), for: .touchUpInside)
        cancelButton.setTitle("X", for: .normal)
        cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25.0)
        self.view.addSubview(cancelButton)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    func dismissView() {
        self.dismiss(animated: true, completion: nil)
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

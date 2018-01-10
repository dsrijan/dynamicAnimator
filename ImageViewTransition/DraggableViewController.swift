//
//  DraggableViewController.swift
//  CircularTransition
//
//  Created by Srijan on 03/11/17.
//  Copyright © 2017 Training. All rights reserved.
//

import UIKit

class DraggableViewController: UIViewController {
    
    
    var customDraggableView : UIView!
    
    var cameraIcon : UIButton!
    
    var phoneIcon : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        customDraggableView = UIView(frame: CGRect(x: 0, y: self.view.bounds.height - 50 , width: self.view.bounds.width, height: 200))
        customDraggableView.layer.borderWidth = 1.0
        customDraggableView.layer.borderColor = UIColor.darkGray.cgColor
        customDraggableView.layer.shadowColor = UIColor.darkGray.cgColor
        self.view.addSubview(customDraggableView)
        
        
        cameraIcon = UIButton(frame: CGRect(x: self.view.bounds.width - 40 , y: 10 , width: 30, height: 30))
        cameraIcon.setImage(UIImage(named: "camera"), for: .normal)
        customDraggableView.addSubview(cameraIcon)
        
        phoneIcon = UIButton(frame: CGRect(x: self.view.bounds.width - 80 , y: 10 , width: 30, height: 30))
        phoneIcon.setImage(UIImage(named: "phone"), for: .normal)
        customDraggableView.addSubview(phoneIcon)
        
        
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        customDraggableView.addGestureRecognizer(dragGesture)
        
        
        let tapGestureOrganiser = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.view.addGestureRecognizer(tapGestureOrganiser)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func tapGesture() {
        if self.customDraggableView.frame.origin.y != self.view.bounds.height - 50 {
            UIView.animate(withDuration: 0.5, animations: {
                self.customDraggableView.frame.origin.y = self.view.bounds.height - 50
            })
        }
    }
    
    func panGesture(gestureRecognizer: UIPanGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizerState.began || gestureRecognizer.state == UIGestureRecognizerState.changed {
            let translation = gestureRecognizer.translation(in: self.view)
            print(gestureRecognizer.view!.center.y)
            if(gestureRecognizer.view!.center.y < 555) {
                print("hello")
                
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: gestureRecognizer.view!.center.y + translation.y)
            }else {
                
                
                if gestureRecognizer.direction == .bottomToTop {
                    print("yooooo")
                        gestureRecognizer.view!.center =  CGPoint(x: gestureRecognizer.view!.center.x, y: 554)
                }else{
                    UIView.animate(withDuration: 0.5, animations: {
                        self.customDraggableView.frame.origin.y = self.view.bounds.height - 50
                    })
                }
                
                
            
            }
            
            gestureRecognizer.setTranslation(CGPoint(x: 0,y: 0), in: self.view)
        }
        
        
        
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



public enum UIPanGestureRecognizerDirection {
    case undefined
    case bottomToTop
    case topToBottom
    case rightToLeft
    case leftToRight
}
public enum TransitionOrientation {
    case unknown
    case topToBottom
    case bottomToTop
    case leftToRight
    case rightToLeft
}


extension UIPanGestureRecognizer {
    public var direction: UIPanGestureRecognizerDirection {
        let velocity = self.velocity(in: view)
        let isVertical = fabs(velocity.y) > fabs(velocity.x)
        
        var direction: UIPanGestureRecognizerDirection
        
        if isVertical {
            direction = velocity.y > 0 ? .topToBottom : .bottomToTop
        } else {
            direction = velocity.x > 0 ? .leftToRight : .rightToLeft
        }
        
        return direction
    }
    
    public func isQuickSwipe(for orientation: TransitionOrientation) -> Bool {
        let velocity = self.velocity(in: view)
        return isQuickSwipeForVelocity(velocity, for: orientation)
    }
    
    private func isQuickSwipeForVelocity(_ velocity: CGPoint, for orientation: TransitionOrientation) -> Bool {
        switch orientation {
        case .unknown : return false
        case .topToBottom : return velocity.y > 1000
        case .bottomToTop : return velocity.y < -1000
        case .leftToRight : return velocity.x > 1000
        case .rightToLeft : return velocity.x < -1000
        }
    }
}

extension UIPanGestureRecognizer {
    typealias GestureHandlingTuple = (gesture: UIPanGestureRecognizer? , handle: (UIPanGestureRecognizer) -> ())
    fileprivate static var handlers = [GestureHandlingTuple]()
    
    public convenience init(gestureHandle: @escaping (UIPanGestureRecognizer) -> ()) {
        self.init()
        UIPanGestureRecognizer.cleanup()
        set(gestureHandle: gestureHandle)
    }
    
    public func set(gestureHandle: @escaping (UIPanGestureRecognizer) -> ()) {
        weak var weakSelf = self
        let tuple = (weakSelf, gestureHandle)
        UIPanGestureRecognizer.handlers.append(tuple)
        addTarget(self, action: #selector(handleGesture))
    }
    
    fileprivate static func cleanup() {
        handlers = handlers.filter { $0.0?.view != nil }
    }
    
    @objc private func handleGesture(_ gesture: UIPanGestureRecognizer) {
        let handleTuples = UIPanGestureRecognizer.handlers.filter{ $0.gesture === self }
        handleTuples.forEach { $0.handle(gesture)}
    }
}

extension UIPanGestureRecognizerDirection {
    public var orientation: TransitionOrientation {
        switch self {
        case .rightToLeft: return .rightToLeft
        case .leftToRight: return .leftToRight
        case .bottomToTop: return .bottomToTop
        case .topToBottom: return .topToBottom
        default: return .unknown
        }
    }
}

extension UIPanGestureRecognizerDirection {
    public var isHorizontal: Bool {
        switch self {
        case .rightToLeft, .leftToRight:
            return true
        default:
            return false
        }
    }
}

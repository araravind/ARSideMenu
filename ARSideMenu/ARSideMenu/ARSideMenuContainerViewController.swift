//
//  ARSlideMenuContainerViewController.swift
//  MySwiftTest
//
//  Created by Aravind A R on 04/04/17.
//  Copyright © 2017 Aravind A R. All rights reserved.
//

import UIKit

enum sideMenuAnimations {
    case slideAlong
    case slideandScaleDown
}

class ARSideMenuContainerViewController: UIViewController, UIGestureRecognizerDelegate {
    
    internal var shadowView:UIView?
    internal var centralContainerView:UIView?
    internal var rightContainerView:UIView?
    
    var centralViewController:UIViewController? {
        
        willSet {
            
            centralViewController?.willMove(toParentViewController: nil)
            centralContainerView?.subviews.forEach({$0.removeFromSuperview()})
            centralViewController?.removeFromParentViewController()
            centralViewController?.didMove(toParentViewController: nil)
        }
        
        didSet {
            initCentralViewController()
        }
    }
    var rightViewController:UIViewController? {
        
        willSet {
            rightViewController?.willMove(toParentViewController: nil)
            rightContainerView?.subviews.forEach({$0.removeFromSuperview()})
            rightViewController?.removeFromParentViewController()
            rightViewController?.didMove(toParentViewController: nil)
        }
        
        didSet {
            initLeftViewController()
        }
    }
    var rightContainerWidth:CGFloat = 230
    private var isSideMenuOpen:Bool = false
    private var centralTapGuesture:UITapGestureRecognizer?
    private var shouldOpenSideMenu:Bool = true
    var sideMenuAnimationType:sideMenuAnimations = .slideAlong
    
    convenience init(rightController:UIViewController, centerController:UIViewController) {
        self.init()
        self.rightViewController = rightController
        self.centralViewController = centerController
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.centralContainerView = UIView(frame: self.view.bounds)
        self.shadowView = UIView(frame: self.view.bounds)
        self.rightContainerView = UIView(frame: self.view.bounds)
        
        self.shadowView?.backgroundColor = UIColor.clear
        self.centralContainerView?.backgroundColor = UIColor.white
        self.rightContainerView?.backgroundColor = UIColor.white
        
        shadowView?.layer.shadowColor = UIColor.gray.cgColor
        shadowView?.layer.shadowOffset = CGSize(width: -5, height: 5)
        shadowView?.layer.shadowOpacity = 0.25
        shadowView?.layer.shadowRadius = 10
        shadowView?.layer.masksToBounds = false
        
        shadowView?.addSubview(self.centralContainerView!)
        self.view.addSubview(self.rightContainerView!)
        self.view.addSubview(self.shadowView!)
        
        //        let centralContainerRightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(centralContainerRightSwipeHandler))
        //        centralContainerRightSwipeGesture.direction = UISwipeGestureRecognizerDirection.right
        //        centralContainerRightSwipeGesture.delegate = self
        //        self.centralContainerView?.addGestureRecognizer(centralContainerRightSwipeGesture)
        //        let centralContainerLeftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(centralContainerLeftSwipeHandler))
        //        centralContainerLeftSwipeGesture.direction = UISwipeGestureRecognizerDirection.left
        //        centralContainerRightSwipeGesture.delegate = self
        //        self.centralContainerView?.addGestureRecognizer(centralContainerLeftSwipeGesture)
        
        self.centralTapGuesture = UITapGestureRecognizer(target: self, action: #selector(centralContainerTapHandler))
        self.centralTapGuesture?.delegate = self
        
        initLeftViewController()
        initCentralViewController()
        
    }
    
    override var childViewControllerForStatusBarStyle: UIViewController? {
        
        return centralViewController
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    internal func initCentralViewController(){
        
        guard let centralViewController = centralViewController, let centralContainerView = centralContainerView  else {
            return
        }
        
        centralViewController.willMove(toParentViewController: self)
        centralViewController.view.frame = centralContainerView.bounds
        centralContainerView.addSubview(centralViewController.view)
        addChildViewController(centralViewController)
        centralViewController.didMove(toParentViewController: self)
        
        if let navController  = centralViewController as? UINavigationController {
            navController.visibleViewController?.view.isUserInteractionEnabled = true
        }
        
        if isSideMenuOpen {
            closeSideMenu()
        }
    }
    
    internal func initLeftViewController(){
        
        guard let rightViewController = rightViewController, let rightContainerView = rightContainerView  else {
            return
        }
        
        rightViewController.willMove(toParentViewController: self)
        rightViewController.view.frame = rightContainerView.bounds
        //        leftContainerView.addSubview(leftViewController.view)
        addChildViewController(rightViewController)
        //        leftViewController .didMove(toParentViewController: self)
        
        
    }
    
    @objc internal func centralContainerRightSwipeHandler(){
        
        if shouldOpenSideMenu{
            
            if isSideMenuOpen{
                return
            } else {
                showSideMenu()
            }
        }
        
        
    }
    
    @objc internal func centralContainerLeftSwipeHandler(){
        
        if isSideMenuOpen {
            closeSideMenu()
        } else {
            return
        }
    }
    
    @objc internal func centralContainerTapHandler(){
        if isSideMenuOpen {
            closeSideMenu()
        } else {
            return
        }
    }
    
    func showSideMenu(){
        
        guard let shadowView = shadowView, let centralContainerView = centralContainerView, let rightContainerView = rightContainerView, let rightViewController = rightViewController else {
            return
        }
        
        rightViewController.willMove(toParentViewController: self)
        rightViewController.view.frame = rightContainerView.bounds
        rightContainerView.addSubview(rightViewController.view)
        addChildViewController(rightViewController)
        
        if let navController  = rightViewController as? UINavigationController {
            navController.visibleViewController?.view.isUserInteractionEnabled = true
        }
        
        if sideMenuAnimationType == .slideAlong {
            
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
                centralContainerView.frame = CGRect(x: -self.rightContainerWidth, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                
            }) { (finished) in
                if finished {
                    self.isSideMenuOpen = true
                    centralContainerView.addGestureRecognizer(self.centralTapGuesture!)
                }
            }

        }
        else if sideMenuAnimationType == .slideandScaleDown {
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                
                let scale:CGFloat = 0.8
                
                let transX = -self.rightContainerWidth
                let transY  = (self.view.bounds.size.height - (shadowView.bounds.size.height)) / 2
                
                shadowView.transform = CGAffineTransform(scaleX: scale, y: scale).concatenating(CGAffineTransform(translationX: transX, y: transY))
                
                centralContainerView.layer.cornerRadius = 5.0
                centralContainerView.layer.masksToBounds = true
                
            }) { (finished) in
                if finished {
                    
                    self.isSideMenuOpen = true
                    self.centralViewController?.view.isUserInteractionEnabled = false
                    centralContainerView.addGestureRecognizer(self.centralTapGuesture!)
                    rightViewController.didMove(toParentViewController: self)
                }
            }

        }
        
        
    }
    
    func closeSideMenu(){
        
        self.rightViewController?.willMove(toParentViewController: nil)
        
        if sideMenuAnimationType == .slideAlong {
            
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
                self.centralContainerView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }) { (finished) in
                if finished {
                    self.isSideMenuOpen = false
                    self.centralContainerView?.removeGestureRecognizer(self.centralTapGuesture!)
                }
            }
        }
        else if sideMenuAnimationType == .slideandScaleDown {
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                
                self.shadowView?.transform = CGAffineTransform.identity
                
                
            }) { (finished) in
                if finished {
                    self.isSideMenuOpen = false
                    self.centralViewController?.view.isUserInteractionEnabled = true
                    self.centralContainerView?.removeGestureRecognizer(self.centralTapGuesture!)
                    self.centralContainerView?.layer.cornerRadius = 0.0
                    
                    self.rightViewController!.view.removeFromSuperview()
                    self.rightViewController?.removeFromParentViewController()
                    self.rightViewController? .didMove(toParentViewController: nil)
                }
            }
        }

        
    }
    
    func toggleSideMenu(){
        
        if (isSideMenuOpen) {
            closeSideMenu()
        } else {
            showSideMenu()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- UIGestureRecognizer Delegate
    
    internal func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

extension UIViewController {
    
    var slideMenuController:ARSideMenuContainerViewController? {
        
        get {
            
            if let menuController =  self.parent as? ARSideMenuContainerViewController {
                
                return menuController
                
            } else if let menuController = self.navigationController?.parent as? ARSideMenuContainerViewController {
                
                return menuController
            }
            
            return nil
        }
    }
    
}


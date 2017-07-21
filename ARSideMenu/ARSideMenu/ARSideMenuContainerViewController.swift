//
//  ARSlideMenuContainerViewController.swift
//  MySwiftTest
//
//  Created by Aravind A R on 04/04/17.
//  Copyright © 2017 Aravind A R. All rights reserved.
//

import UIKit

class ARSideMenuContainerViewController: UIViewController {
    var centralContainerView:UIView!
    var leftContainerView:UIView!
    var centralViewController:UIViewController!
    var leftViewController:UIViewController!
    var leftContainerWidth:CGFloat = UIScreen.main.bounds.width - 125.0
    var isSideMenuOpen:Bool = false
    var centralTapGuesture:UITapGestureRecognizer?
    var shouldOpenSideMenu:Bool = true
    var statusBarLight = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.centralContainerView = UIView(frame: self.view.bounds)
        
        self.leftContainerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        self.view.addSubview(self.leftContainerView)
        self.view.addSubview(self.centralContainerView)
        
        self.view.bringSubview(toFront: self.leftContainerView)
        self.view.bringSubview(toFront: self.centralContainerView)
       
        let centralContainerRightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(centralContainerRightSwipeHandler))
        centralContainerRightSwipeGesture.direction = UISwipeGestureRecognizerDirection.right
        self.centralContainerView.addGestureRecognizer(centralContainerRightSwipeGesture)
        let centralContainerLeftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(centralContainerLeftSwipeHandler))
        centralContainerLeftSwipeGesture.direction = UISwipeGestureRecognizerDirection.left
        self.centralContainerView.addGestureRecognizer(centralContainerLeftSwipeGesture)
        self.centralTapGuesture = UITapGestureRecognizer(target: self, action: #selector(centralContainerTapHandler))
       
        initLeftViewController()
        initCentralViewController()
        

        // Do any additional setup after loading the view.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        if statusBarLight {
            return .lightContent
        }
        
        return .default
        
    }
    func initCentralViewController(){
        for vc in childViewControllers {
            
            if vc.view.tag != 105 {
                vc.view.removeFromSuperview()
                vc.removeFromParentViewController()
                vc.didMove(toParentViewController: nil)
            }
   
        }
        
        centralViewController.view.frame = centralContainerView.bounds
        centralContainerView .addSubview(centralViewController.view)
        addChildViewController(centralViewController)
        centralViewController .didMove(toParentViewController: self)
        
        if let navController  = centralViewController as? UINavigationController {
            navController.visibleViewController?.view.isUserInteractionEnabled = true
        }
        
        if isSideMenuOpen {
            closeSideMenu()
        }
    
    }
    func initLeftViewController(){
       
        leftViewController.view.tag = 105
        leftViewController.view.frame = leftContainerView.bounds
        leftContainerView .addSubview(leftViewController.view)
        addChildViewController(leftViewController)
        leftViewController .didMove(toParentViewController: self)
        
        if let navController  = leftViewController as? UINavigationController {
            navController.visibleViewController?.view.isUserInteractionEnabled = true
        }

    }
    
    func centralContainerRightSwipeHandler(){
        
        if shouldOpenSideMenu{
            
            if isSideMenuOpen{
                return
            } else {
                openSideMenu()
            }
        }
       
        
    }
    func centralContainerLeftSwipeHandler(){
        
        if isSideMenuOpen {
            closeSideMenu()
        } else {
            return
        }
    }
    
    func centralContainerTapHandler(){
        if isSideMenuOpen {
            closeSideMenu()
        } else {
            return
        }
    }
    func openSideMenu(){
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
            self.centralContainerView.frame = CGRect(x: self.leftContainerWidth, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)

        }) { (finished) in
            if finished {
                self.isSideMenuOpen = true
                self.centralContainerView.addGestureRecognizer(self.centralTapGuesture!)
            }
        }

       
    }
    
    func closeSideMenu(){
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.centralContainerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }) { (finished) in
            if finished {
                self.isSideMenuOpen = false
                self.centralContainerView.removeGestureRecognizer(self.centralTapGuesture!)
            }
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

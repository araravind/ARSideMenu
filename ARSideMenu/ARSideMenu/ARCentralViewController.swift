//
//  ViewController.swift
//  ARSideMenu
//
//  Created by Aravind A R on 21/07/17.
//  Copyright © 2017 Aravind A R. All rights reserved.
//

import UIKit

class ARCentralViewController: UIViewController {
    
    override func viewDidLoad() {
        
        let leftBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "menuIcon"), style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButton
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func leftBarButtonTapped(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.sideMenuContainerViewController?.toggleSideMenu()
    }
}


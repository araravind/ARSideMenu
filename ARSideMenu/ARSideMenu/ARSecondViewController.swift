//
//  ARSecondViewController.swift
//  ARSideMenu
//
//  Created by Aravind A R on 21/07/17.
//  Copyright © 2017 Aravind A R. All rights reserved.
//

import UIKit

class ARSecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let leftBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "menuIcon"), style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButton
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func leftBarButtonTapped(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.sideMenuContainerViewController?.toggleSideMenu()
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

//
//  ARRightMenuViewController.swift
//  ARSideMenu
//
//  Created by Aravind A R on 21/07/17.
//  Copyright © 2017 Aravind A R. All rights reserved.
//

import UIKit

class ARRightMenuViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var menuTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MAR::- UITableView Delegate And DataSource
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leftMenuTableViewCell", for: indexPath)
        cell.textLabel?.text = "ViewController \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:navigateToFirstVC()
            break
        case 1:navigateToSecondVC()
            break
        
        default:
            break
        }
    }
    
    //switch ViewControllers
    
    func navigateToFirstVC(){
        
        let storyBoard = UIStoryboard(name: "Main",bundle: nil)
        let firstVC = storyBoard.instantiateViewController(withIdentifier: "centralNavigationVC")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.sideMenuContainerViewController?.centralViewController = firstVC
        appDelegate.sideMenuContainerViewController?.initCentralViewController()
        appDelegate.sideMenuContainerViewController?.closeSideMenu()

    }
    
    func navigateToSecondVC(){
        let storyBoard = UIStoryboard(name: "Main",bundle: nil)
        let secondVC = storyBoard.instantiateViewController(withIdentifier: "secondNavigationVC") 
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.sideMenuContainerViewController?.centralViewController = secondVC
        appDelegate.sideMenuContainerViewController?.initCentralViewController()
        appDelegate.sideMenuContainerViewController?.closeSideMenu()
        
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

//
//  NRHomeViewController.swift
//  near
//
//  Created by vincent on 2017/02/04.
//  Copyright © 2017年 vc7. All rights reserved.
//

import UIKit

class NRHomeViewController: UIViewController {
    
    /// The main table view to hold data
    @IBOutlet internal weak var tableView: UITableView!
    
    
    @IBOutlet internal weak var locationInformationHUD: UIView!
    
    @IBOutlet weak var locationInformationHUDTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

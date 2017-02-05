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
    
    /// The HUD to display the basic weather information
    @IBOutlet internal weak var locationInformationHUD: UIView!
    
    @IBOutlet internal weak var locationInformationHUDTopConstraint: NSLayoutConstraint!
    @IBOutlet internal weak var locationInformationHUDHeightConstraint: NSLayoutConstraint! {
        didSet {
            locationInformationHUDHeight = locationInformationHUDHeightConstraint.constant
        }
    }
    internal var locationInformationHUDHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(self.locationInformationHUDHeightConstraint.constant, 0, 0, 0)
        self.tableView.contentInset = UIEdgeInsetsMake(self.locationInformationHUDHeightConstraint.constant, 0, 0, 0)
        
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension NRHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension NRHomeViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        if contentOffsetY < -self.locationInformationHUDHeight {
            self.locationInformationHUDTopConstraint.constant = 0
            self.locationInformationHUD.alpha = 1
        } else if contentOffsetY > 0 {
            self.locationInformationHUDTopConstraint.constant = self.locationInformationHUDHeight
            self.locationInformationHUD.alpha = 0
        } else {
            self.locationInformationHUDTopConstraint.constant = (-self.locationInformationHUDHeight - contentOffsetY) / 2
            self.locationInformationHUD.alpha = (-contentOffsetY) / self.locationInformationHUDHeight
        }
    }
}

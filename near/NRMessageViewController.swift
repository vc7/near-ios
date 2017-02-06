//
//  NRMessageViewController.swift
//  near
//
//  Created by vincent on 2017/02/06.
//  Copyright © 2017年 vc7. All rights reserved.
//

import UIKit

protocol NRMessageViewControllerDelegate: class {
    func didSelectConfirmButton(in messageViewController: NRMessageViewController)
}

/// The view controller to display error message.
class NRMessageViewController: UIViewController {

    weak var delegate: NRMessageViewControllerDelegate?
    
    var message:String = "--" {
        didSet {
            self.messageLabel?.text = message
            self.view.layoutIfNeeded()
        }
    }
    @IBOutlet internal weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.messageLabel.text = self.message
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action Methods
    
    @IBAction func didSelectRetryButton(_ sender: Any) {
        self.delegate?.didSelectConfirmButton(in: self)
    }
    
}

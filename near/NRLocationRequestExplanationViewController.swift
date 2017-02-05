//
//  NRLocationRequestExplanationViewController.swift
//  near
//
//  Created by vincent on 2017/02/05.
//  Copyright © 2017年 vc7. All rights reserved.
//

import UIKit

protocol NRLocationRequestExplanationViewControllerDelegate: class {
    func didConfirmInExplanationViewController(_ explanationViewController: NRLocationRequestExplanationViewController)
}

class NRLocationRequestExplanationViewController: UIViewController {

    weak var delegate: NRLocationRequestExplanationViewControllerDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.setup()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
        self.setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setup Helpers
    
    private func setup() {
        self.modalPresentationStyle = .custom
        self.modalTransitionStyle = .crossDissolve
    }
    
    // MARK: - Button Action Methods
    
    @IBAction private func didSelectConfirmButton(_ sender: Any) {
        self.delegate?.didConfirmInExplanationViewController(self)
    }
}

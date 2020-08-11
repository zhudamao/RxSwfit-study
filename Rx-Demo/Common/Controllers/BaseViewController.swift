//
//  BaseViewController.swift
//  Rx-Demo
//
//  Created by Zhu on 2020/5/13.
//  Copyright © 2020 Zhu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
	var hiddenNav:Bool?
    
	override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
		
        // Do any additional setup after loading the view.
		setNavItems()
		setLayOut()
    }
    
	func setLayOut(){
		
	}
	
	func setNavItems() {
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		navigationController?.setNavigationBarHidden(hiddenNav ?? false, animated: animated);
	}
	
	deinit {
		debugPrint(self)
	}
}

extension BaseViewController{
	override var preferredStatusBarStyle: UIStatusBarStyle{
		return .default
	}
}

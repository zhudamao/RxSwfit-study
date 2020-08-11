//
//  MainTabController.swift
//  Rx-Demo
//
//  Created by Zhu on 2020/5/13.
//  Copyright © 2020 Zhu. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

		let ctrl = MainViewController()
		
		let nav0 = BaseNavigationController(rootViewController: ctrl)
		nav0.tabBarItem = UITabBarItem(title: NSLocalizedString("main", comment: ""), image:UIImage(named: "tab0")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tab0_h")?.withRenderingMode(.alwaysOriginal))
		
		
		let ctrl1 = SecondViewController()
		
		let nav1 = BaseNavigationController(rootViewController: ctrl1)
		nav1.tabBarItem = UITabBarItem(title: NSLocalizedString("mine", comment: ""), image:UIImage(named: "tab1")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tab1_h")?.withRenderingMode(.alwaysOriginal))
		
		let ctrl2 = LoginViewController()
		
		let nav2 = BaseNavigationController(rootViewController: ctrl2)
		nav2.tabBarItem = UITabBarItem(title: NSLocalizedString("login", comment: ""), image:UIImage(named: "login")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "login_h")?.withRenderingMode(.alwaysOriginal))
		
		self.viewControllers = [nav0,nav1,nav2]
    }


}

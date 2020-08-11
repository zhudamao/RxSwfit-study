//
//  AppDelegate.swift
//  Rx-Demo
//
//  Created by Zhu on 2020/5/13.
//  Copyright © 2020 Zhu. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.backgroundColor =  .white
		window?.rootViewController = MainTabController()
		window?.makeKeyAndVisible()
		
		iQKeyboardManagerInit()
		
		return true
	}
	
	func iQKeyboardManagerInit()  {
		IQKeyboardManager.shared.enable = true
		//控制点击背景是否收起键盘
		IQKeyboardManager.shared.shouldResignOnTouchOutside = true
	   //控制键盘上的工具条文字颜色是否用户自定义
		//IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
		 //      IQKeyboardManager.sharedManager().shouldToolbarUsesTextFieldTintColor = true
		// 控制是否显示键盘上的工具条
		IQKeyboardManager.shared.enableAutoToolbar = true
	   //最新版的设置键盘的returnKey的关键字 ,可以点击键盘上的next键，自动跳转到下一个输入框，最后一个输入框点击完成，自动收起键盘
		IQKeyboardManager.shared.toolbarManageBehaviour = .byPosition
	}
}

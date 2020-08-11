//
//  LoginSuccessController.swift
//  Rx-Demo
//
//  Created by Zhu on 2020/5/19.
//  Copyright © 2020 Zhu. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import SnapKitExtend

class LoginSuccessController: BaseViewController {
	var successInfo:LoginInfo?
	
	private let disposeBag = DisposeBag()
    
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	override func setLayOut() {
		let lable = UILabel()
		lable.font = UIFont.systemFont(ofSize: 14.0);
		lable.numberOfLines = 0;
		
		view.addSubview(lable)
		lable.snp.makeConstraints { (make) in
			if #available(iOS 11.0, *) {
				make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
			} else {
				make.top.equalTo(topLayoutGuide.snp.top).offset(20)
			}
			make.left.equalToSuperview().offset(20)
			make.right.equalToSuperview().offset(-20)
		}
		
		lable.text = successInfo?.toJSONString()
		
		
		let threeBtnsView = UIView()
		view.addSubview(threeBtnsView)
		threeBtnsView.snp.makeConstraints { (make) in
			make.centerY.equalToSuperview()
			make.left.right.equalToSuperview()
		}
		
		{
			var btns:[UIButton] = []
			
			for i in 0..<3 {
				let btn = UIButton(type: .custom)
				btn.setBackgroundImage(UIImage.imageWithColor(UIColor.hex(hexString: "eeeeee")), for: .normal)
				btn.setBackgroundImage(UIImage.imageWithColor(UIColor.hex(hexString: "4682B4")), for: .selected)
				btn.setTitle("\(i)", for: .normal)
				btn.setTitle("\(i*100)", for: .selected)
				btn.setTitleColor(UIColor.hex(hexString: "333333"), for: .normal)
				btn.setTitleColor(UIColor.hex(hexString: "fefefe"), for: .selected)
				btns.append(btn)
				
				threeBtnsView.addSubview(btn)
			}
		
			btns.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: 10, leadSpacing: 20, tailSpacing: 20)
			btns.snp.makeConstraints { (make) in
				make.height.equalTo(40)
				make.top.bottom.equalToSuperview();
			}
// 用按钮选出选中的按钮。遍历按钮 bind to selected
			let selectedBtn = Observable.from(btns.map({ button in
				button.rx.tap.map{ button }
				})).merge()
			
			for btn in btns {
				selectedBtn.map { $0 == btn }.bind(to: btn.rx.isSelected).disposed(by: disposeBag)
			}
			
		}()
		
	}
	
	override func setNavItems() {
		self.navigationItem.title = NSLocalizedString("loginSuccess", comment: "")
	}

}

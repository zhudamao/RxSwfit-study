//
//  SecondViewController.swift
//  Rx-Demo
//
//  Created by Zhu on 2020/5/13.
//  Copyright © 2020 Zhu. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SecondViewController: BaseViewController {
	private let idntifier = "UITableViewCell";
	
	
	private lazy var tableView:UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: idntifier)
		tableView.separatorInset = .zero
		return tableView
	}()
	
	
	private lazy var headerView:UIView = {
		let header = UIView(frame: .zero)
		
		let contentView = UIView(frame: .zero);
		
		contentView.addSubview(self.textFiled)
		
		self.textFiled.snp.makeConstraints { (make) in
			make.edges.equalToSuperview().inset(UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8))
		}
		
		contentView.layer.cornerRadius = 4.0;
		contentView.backgroundColor = UIColor.hex(hexString: "eeeeee")
		
		header.addSubview(contentView)
		contentView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview().inset(UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8))
		}
		
		return header;
	}()
	
	private lazy var textFiled:UITextField = {
		let textFiled = UITextField(frame: .zero)
		textFiled.font = UIFont.systemFont(ofSize: 14, weight: .light)
		textFiled.placeholder = NSLocalizedString("searchKey", comment: "");
		textFiled.clearButtonMode = .whileEditing
		
		return textFiled
	}()
	
	private let disposeBag = DisposeBag()
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	override func setLayOut() {
		view.addSubview(headerView)
		view.addSubview(tableView)
		
		headerView.snp.makeConstraints { (make) in
			make.left.right.equalToSuperview()
			if #available(iOS 11.0, *){
				make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
			}else {
				make.top.equalTo(topLayoutGuide.snp.top)
			}
			//make.height.equalTo(40)
		}
		
		tableView.snp.makeConstraints { (make) in
			make.left.right.equalTo(headerView)
			make.top.equalTo(headerView.snp.bottom)
			
			if #available(iOS 11.0, *){
				make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
			}else {
				make.bottom.equalTo(bottomLayoutGuide.snp.bottom)
			}
		}
		
		let viewModel = SecondViewModel(inputText: self.textFiled.rx.text.orEmpty.asObservable(), dependency: (disposeBag,NetworkService.shared))
		viewModel.tableData.asDriver().drive(tableView.rx.items) { [unowned self](tableView,row,element) in
			let cell = tableView.dequeueReusableCell(withIdentifier: self.idntifier)
			cell?.textLabel?.font  = UIFont.systemFont(ofSize: 14, weight: .light)
			cell?.textLabel?.text = element
			return cell!;
		}.disposed(by: disposeBag)
		
		tableView.rx.modelSelected(String.self).subscribe(onNext: { [unowned self](item:String) in
			let percent = item.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
			let webCtrl = WebController(url:"https://www.baidu.com/s?wd=\(percent!)")
			
			self.navigationController?.pushViewController(webCtrl, animated: true)
		}).disposed(by: disposeBag)
		
	}
	
	override func setNavItems() {
		navigationItem.title = NSLocalizedString("mine", comment: "");
	}
    

}

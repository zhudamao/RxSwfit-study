//
//  BidDetailViewController.swift
//  Rx-Demo
//
//  Created by Zhu on 2020/5/14.
//  Copyright © 2020 Zhu. All rights reserved.
//

import UIKit

class BidDetailViewController: BaseViewController {
	var bidItem:BidItem? {
		didSet{
			guard let bidItem = bidItem else {
				return
			}
			navigationItem.title = bidItem.name
			
			if let data = bidItem.content.data(using: .unicode){
				do {
					let attributeStr = try NSAttributedString(data:data,options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html],documentAttributes: nil)

					detailLable.attributedText = attributeStr;
				} catch {

				}
			}
		}
	}
	
	private lazy var detailLable:UILabel = {
		let lable = UILabel()
		lable.numberOfLines = 0;
		return lable;
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func setNavItems() {
		navigationItem.title = NSLocalizedString("bidDetail", comment: "")
		//navigationItem.hidesBackButton = true
	}
	
	override func setLayOut() {
		let scrollView = UIScrollView()
		self.view.addSubview(scrollView)
		
//		scrollView.snp.makeConstraints { (make) in
//			if #available(iOS 11.0,*){
//				make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//				make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
//			}else{
//				make.top.equalTo(topLayoutGuide.snp.top)
//				make.bottom.equalTo(bottomLayoutGuide.snp.bottom)
//			}
//			make.left.right.equalToSuperview()
//		}
		scrollView.snp.makeConstraints { (make) in
			make.edges.equalTo(self.view.usnp.edges)
		}
		
		let contentView = UIView()
		scrollView.addSubview(contentView)
		
		contentView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview();
			make.width.equalToSuperview();
		};
		
		contentView.addSubview(detailLable)
		detailLable.snp.makeConstraints { (make) in
			make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16))
		}
		
//		contentView.snp.makeConstraints { (make) in
//			make.bottom.equalTo(detailLable).offset(10)
//		}
	}

}

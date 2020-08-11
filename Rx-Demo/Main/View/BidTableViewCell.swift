//
//  BidTableViewCell.swift
//  Rx-Demo
//
//  Created by Zhu on 2020/5/14.
//  Copyright © 2020 Zhu. All rights reserved.
//

import UIKit
import SnapKit
import Reusable

class BidTableViewCell: UITableViewCell, Reusable {
	private lazy var  nameLable:UILabel = {
		let lable  = UILabel()
		lable.numberOfLines = 2
		lable.font = UIFont.systemFont(ofSize: 14.0)
		lable.textColor = .darkGray
		return lable
	}()
	
	private lazy var  contentLable:UILabel = {
		let lable  = UILabel()
		lable.numberOfLines = 2
		return lable
	}()

	
	private lazy var  fromLable:UILabel = {
		let lable  = UILabel();
		lable.font = UIFont.systemFont(ofSize: 12.0)
		lable.textColor = .lightGray
		return lable
	}()
	
	private lazy var  timeLable:UILabel = {
		let lable  = UILabel();
		lable.font = UIFont.systemFont(ofSize: 12.0)
		lable.textColor = .lightGray
		return lable
	}()
	

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		let paddingView = UIView()
		contentView.addSubview(paddingView)
		paddingView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16))
		}
		
		paddingView.addSubview(nameLable);
		
		nameLable.snp.makeConstraints { (make) in
			make.top.left.equalToSuperview()
			make.right.lessThanOrEqualTo(paddingView)
		}
		
		paddingView.addSubview(contentLable)
		
		contentLable.snp.makeConstraints { (make) in
			make.left.right.equalToSuperview()
			make.top.equalTo(nameLable.snp.bottom).offset(4)
		};
		
		let lable0 = UILabel()
		lable0.text = NSLocalizedString("source", comment: "")
		lable0.font = UIFont.systemFont(ofSize: 12.0)
		lable0.textColor = .lightGray
		
		paddingView .addSubview(lable0)
		lable0.snp.makeConstraints { (make) in
			make.left.equalToSuperview()
			make.top.equalTo(contentLable.snp.bottom).offset(4)
		}
		
		paddingView.addSubview(fromLable);
		fromLable.snp.makeConstraints { (make) in
			make.left.equalTo(lable0.snp.right)
			make.centerY.equalTo(lable0)
		}
		
		paddingView.addSubview(timeLable)
		
		let lable1 = UILabel()
		
		lable1.text = NSLocalizedString("bidDate", comment: "")
		lable1.font = UIFont.systemFont(ofSize: 12.0)
		lable1.textColor = .lightGray
		paddingView.addSubview(lable1)
		
		lable1.snp.makeConstraints { (make) in
			make.left.equalToSuperview()
			make.top.equalTo(lable0.snp.bottom).offset(4)
			make.bottom.equalToSuperview()
		}
		
		timeLable.snp.makeConstraints { (make) in
			make.left.equalTo(lable1.snp.right)
			make.centerY.equalTo(lable1)
		}
	}
	
	var bidItem:BidItem? {
		didSet {
			guard let bidItem = bidItem else{
				return
			}
			
			nameLable.text = bidItem.name
			fromLable.text = bidItem.source
			timeLable.text = bidItem.formatPubTime
			

		}
	}

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

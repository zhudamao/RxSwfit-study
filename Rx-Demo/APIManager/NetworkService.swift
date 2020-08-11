//
//  NetworkService.swift
//  Rx-Demo
//
//  Created by Zhu on 2020/5/15.
//  Copyright © 2020 Zhu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

class NetworkService: NSObject {
	static let shared = NetworkService()
	
	func getCurrentBid(page:Int,pageSize:Int,matchtype:Int) -> Driver<[BidItem]> {
		return APIProvider.rx.request(.coureDetail(page, pageSize, matchtype)).mapResponseToObjectArray(type: BidItem.self).asDriver(onErrorJustReturn: []);
	}
	
	func getAiKeysBy(key:String) -> Driver<[String]>{
		return APIProvider.rx.request(.autokeys(key)).mapResponseToStringArray().asDriver(onErrorJustReturn: []);
	}
}



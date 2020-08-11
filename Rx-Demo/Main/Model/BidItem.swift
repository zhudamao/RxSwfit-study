//
//  BidItem.swift
//  Rx-Demo
//
//  Created by Zhu on 2020/5/14.
//  Copyright © 2020 Zhu. All rights reserved.
//

import Foundation
import ObjectMapper

struct BidItem :Mappable {
	init?(map: Map) {
	}
	
	mutating func mapping(map: Map) {
		utags <- map["utags"]
		formatPubTime <- map["formatPubTime"]
		id <- map["id"]
		name <- map["name"]
		words <- map["words"]
		bidsno <- map["bidsno"]
		pubtime <- map["pubtime"]
		company <- map["company"]
		content <- map["content"]
		addtime <- map["addtime"]
		source <- map["source"]
		link <- map["link"]
		tags <- map["tags"]
		isdel <- map["isdel"]
	}
	
	var utags: String = ""
	var formatPubTime: String = ""
	var id: Int = 0
	var name:String = ""
	var words:String = ""
	var bidsno:String = ""
	var pubtime:String = ""
	var company:String = ""
	var content:String = ""
	var addtime:String = ""
	var source:String = ""
	var link:String = ""
	var tags:String = ""
	var isdel:Bool = false

}

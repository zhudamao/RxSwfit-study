//
//  LoginInfo.swift
//  Rx-Demo
//
//  Created by Zhu on 2020/5/19.
//  Copyright © 2020 Zhu. All rights reserved.
//

import UIKit
import ObjectMapper

struct LoginInfo : Mappable {
	init?(map: Map) {
		phone = ""
		code = ""
		passwd = ""
	}
	
	mutating func mapping(map: Map) {
		phone <- map["phone"]
		code <- map["code"]
		passwd <- map["passwd"]
	}
	
	var phone:String
	var code:String
	var passwd:String
	
	init(phone:String,code:String,passwd:String){
		self.phone = phone
		self.code = code
		self.passwd = passwd
	}
}

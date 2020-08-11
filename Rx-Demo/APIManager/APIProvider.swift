//
//  APIManager.swift
//  Rx-Demo
//
//  Created by Zhu on 2020/5/13.
//  Copyright © 2020 Zhu. All rights reserved.
//

import UIKit
import Moya

let APIProvider = MoyaProvider<TestAPI>()

public enum TestAPI {
	case autokeys(String)
	case coureDetail(Int,Int,Int)
}

extension TestAPI: TargetType{
	public var baseURL: URL {
		return URL(string: "http://api.now.pinzhi.xin/")!
	}
	
	public var path: String {
		switch self {
		case .autokeys:
			return "ai/autokeys"
		case .coureDetail:
			return "bid/list"
		}
	}
	
	public var method: Moya.Method {
		return .get
	}
	
	public var sampleData: Data {
		return Data()
	}
	
	public var task: Task {
		var params:[String:Any] = [:]
		
		switch self {
		case .autokeys(let key):
			params = ["key":key]
		case .coureDetail(let page,let pagesize,let mathDetail):
			params["page"] = page
			params["pagesize"] = pagesize
			params["matchtype"] = mathDetail
			params["uid"] = 135
//		default:
//			return .requestPlain
		}
		return .requestParameters(parameters: params, encoding: URLEncoding.default)
	}
	
	public var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}

}

/*
uid":@([UserModel shareInstance].uid),@"page":@(currentPage),@"pagesize":@10,@"matchtype":@(mathDetail? 2:1)
*/

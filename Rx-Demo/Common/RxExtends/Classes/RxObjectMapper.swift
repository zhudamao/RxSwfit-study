//
//  RxObjectMapper.swift
//  Pods
//
//  Created by Fernando on 30/1/17.
//
//

import ObjectMapper
import RxSwift
import Moya

public enum RxObjectMapperError: Error {
    case parsingError
	case RequestFailed
	case NoResponse
	case unExpectedResult(resultCode:Int? ,resultMsg: String?)
}

private enum RequestStatus:Int {
	case requestSucess = 0
	case requestError
}

private let RESULT_CODE = "code"
private let RESULT_MSG = "desc"
private let RESULT_DATA = "data"

public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
	func mapResponseToObject<T>(type:T.Type) -> Single<T> where T:Mappable {
		return flatMap { response in
			guard ((200...209) ~= response.statusCode) else {
				throw RxObjectMapperError.RequestFailed
			}
			
			
			guard let json = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String:Any] else {
				throw RxObjectMapperError.NoResponse
			}
			
			if let code = json[RESULT_CODE] as? Int{
				if code == RequestStatus.requestSucess.rawValue {
					let data = json[RESULT_DATA]
					if let data = data as? [String:Any]{
						let mapper = Mapper<T>()
						guard let parsedElement = mapper.map(JSONObject: data) else {
							throw RxObjectMapperError.parsingError
						}
						
						return Single.just(parsedElement)
					}
					else{
						throw RxObjectMapperError.parsingError
					}
				}else{
					throw RxObjectMapperError.unExpectedResult(resultCode: json[RESULT_CODE] as? Int, resultMsg: json[RESULT_MSG] as? String)
				}
			}else {
				throw RxObjectMapperError.parsingError
			}
		}
	}


	func mapResponseToObjectArray<T>(type:T.Type) -> Single<[T]> where T:Mappable {
		return flatMap { response in
			guard ((200...209) ~= response.statusCode) else {
				throw RxObjectMapperError.RequestFailed
			}
			
			guard let json = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String:Any] else {
				throw RxObjectMapperError.NoResponse
			}
			
			if let code = json[RESULT_CODE] as? Int{
				if (code == RequestStatus.requestSucess.rawValue){
					let data = json[RESULT_DATA]
					if let data = data as? [Any]{
						let mapper = Mapper<T>()
						guard let parsedArray = mapper.mapArray(JSONObject: data) else {
							throw RxObjectMapperError.parsingError
						}
						
						return Single.just(parsedArray)
					}else{
						throw RxObjectMapperError.parsingError
					}
				}else {
					throw RxObjectMapperError.parsingError
				}
			}else {
				throw RxObjectMapperError.parsingError
			}
		}
	}
	
	func mapResponseToStringArray() -> Single<[String]> {
		return flatMap { response in
			guard ((200...209) ~= response.statusCode) else {
				throw RxObjectMapperError.RequestFailed
			}
			
			guard let json = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String:Any] else {
				throw RxObjectMapperError.NoResponse
			}
			
			if let code = json[RESULT_CODE] as? Int{
				if (code == RequestStatus.requestSucess.rawValue){
					let data = json[RESULT_DATA]
					if let data = data as? [String]{
						return Single.just(data)
					}else{
						throw RxObjectMapperError.parsingError
					}
				}else {
					throw RxObjectMapperError.parsingError
				}
			}else {
				throw RxObjectMapperError.parsingError
			}
		}
	}
}

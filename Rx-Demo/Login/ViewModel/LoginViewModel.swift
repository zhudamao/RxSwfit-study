//
//  LoginViewModel.swift
//  Rx-Demo
//
//  Created by Zhu on 2020/5/18.
//  Copyright © 2020 Zhu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewModel {
	let codeAble:Observable<Bool>
	let actionAble:Observable<Bool>
	let timerText:Observable<String>
	let fixPhone:Observable<String>
	let fixCode:Observable<String>
	let loginRespone: Observable<[String:Any]>
	//let normalText:String = NSLocalizedString("getCode", comment: "")
	
	init(input:(nameInput:Observable<String>,
		passInput:Observable<String>,
		codeInput:Observable<String>,
		codeBtn:ControlEvent<Void>,
		loginBtn:ControlEvent<Void>
		)){
		
			let timer:Int = 60
			let phoneCount  = 11
			let codeCount = 6
			
			let codeAble0 = input.nameInput.map { (phone) -> Bool in
				return phone.count == phoneCount
			}
		
			let tick = input.codeBtn.throttle(0.5, scheduler: MainScheduler.instance).flatMap{ _ -> Observable<Int> in
				return Observable<Int>.timer(0, period: 1, scheduler: MainScheduler.instance).map { (a) -> Int in
						return timer - a
					}.filter{ $0 >= 0}
			}
		
		   timerText = tick.map { "\($0)s"}
			
			codeAble = Observable.combineLatest(codeAble0, tick.map { $0 > 0}.startWith(false)).map({ (enable0,enable1) -> Bool in
				return enable0 && !enable1
				}).startWith(false)

			actionAble = Observable.combineLatest(input.nameInput, input.codeInput,input.passInput).flatMapLatest({ (phone, code, passwd) -> Observable<Bool> in
				return  Observable.just(phone.count == phoneCount && code.count > codeCount - 1 && passwd.count > 0);
			})
		
			fixPhone = input.nameInput.map { (name:String) -> String in
				if (name.count > phoneCount - 1){
					let indexFive = name.index(name.startIndex, offsetBy: phoneCount)
					return  String(name[..<indexFive])
				}

				return name
			}
	
			fixCode = input.codeInput.map { (name:String) -> String in
				if (name.count > codeCount - 1){
					let indexFive = name.index(name.startIndex, offsetBy: codeCount)
					return  String(name[..<indexFive])
				}

				return name
			}
		
		let commit:Observable<[String:Any]> = Observable.combineLatest(input.nameInput, input.passInput, input.codeInput ,resultSelector:{ name, pass, code  in
			return ["phone":name,"pass":pass,"code":code]
		})
		
		loginRespone = input.loginBtn.withLatestFrom(commit).delay(2,scheduler: MainScheduler.instance)
	}
}

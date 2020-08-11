//
//  SecondViewModel.swift
//  Rx-Demo
//
//  Created by Zhu on 2020/5/18.
//  Copyright © 2020 Zhu. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SecondViewModel {
	let tableData:Driver<[String]>
	
	init(inputText:Observable<String>,dependency:(disposeBag:DisposeBag,networkService:NetworkService)) {
		tableData = inputText.startWith("").throttle(0.5, scheduler: MainScheduler.instance).distinctUntilChanged().flatMapLatest { text in
			return dependency.networkService.getAiKeysBy(key:text)}.asDriver(onErrorJustReturn: [])
	}
}


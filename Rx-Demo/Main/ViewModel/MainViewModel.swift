//
//  MainViewModel.swift
//  Rx-Demo
//
//  Created by Zhu on 2020/5/13.
//  Copyright © 2020 Zhu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewModel {
	let tableData = BehaviorRelay<[BidItem]>(value:[])
	
	let endRefreshing: Observable<(Bool,Bool)>
	let restNoMoreData: PublishSubject<Bool>
	
	
	init (input:(footerRefresh:Observable<Void>,headerRefresh:Observable<Void>),dependency:(disposeBag:DisposeBag,networkService:NetworkService)){
		var pageNum = 1
		let pageSize = 10
		
		let headerRefreshData: Observable<[BidItem]> = input.headerRefresh.startWith(()).flatMapLatest { _ in
			return dependency.networkService.getCurrentBid(page:1,pageSize:pageSize,matchtype:1)
		}.takeUntil(input.footerRefresh).share(replay: 1, scope:.whileConnected)
		
		let footerRefreshData: Observable<[BidItem]> = input.footerRefresh.flatMapLatest{ _ in
			return dependency.networkService.getCurrentBid(page:pageNum,pageSize:pageSize,matchtype:1)}.takeUntil(input.footerRefresh).share(replay: 1, scope:.whileConnected)
		
		
		let noMoreDataRefreshing = footerRefreshData.map{$0.count != pageSize}.startWith(false)
		let endHeaderRefreshing = headerRefreshData.map{ _ in true}
		let endFooterRefreshing = footerRefreshData.map{$0.count == pageSize}
		
		self.restNoMoreData = PublishSubject<Bool>()
		
		self.endRefreshing = Observable.combineLatest(Observable.merge([endHeaderRefreshing,endFooterRefreshing]),
													  Observable.merge([endHeaderRefreshing.flatMap({ _ -> Observable<Bool> in
			return Observable.just(false)
		}),noMoreDataRefreshing]) , resultSelector: { isEnd, isEndNoMoreData  in
			return (isEnd,isEndNoMoreData)
		})
		
		headerRefreshData.subscribe(onNext: {  items  in
			self.tableData.accept(items)
			self.restNoMoreData.onNext(true)
		}).disposed(by: dependency.disposeBag)
		
		footerRefreshData.subscribe(onNext: {  items  in
			self.tableData.accept(self.tableData.value + items)
		}).disposed(by: dependency.disposeBag)
	
		headerRefreshData.map{$0.count == pageSize}.subscribe(onNext: { (hasNextPage) in
			if hasNextPage {
				pageNum = 2
			}
		}).disposed(by: dependency.disposeBag)
		
		footerRefreshData.map{$0.count == pageSize}.subscribe(onNext: { (hasNextPage) in
			if hasNextPage {
				pageNum += 1
			}
		}).disposed(by: dependency.disposeBag)
	}
}

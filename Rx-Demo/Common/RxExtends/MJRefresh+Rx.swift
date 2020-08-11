//
//  MJRefresh+Rx.swift
//  WangYiNews
//
//  Created by Zhu on 2020/3/25.
//  Copyright © 2020 grwong. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import MJRefresh

extension Reactive where Base: MJRefreshComponent {
	var refReshing: ControlEvent<Void> {
		let source: Observable<Void> = Observable.create { [weak control = self.base] (observer) -> Disposable in
			
			if let control = control {
				control.refreshingBlock = {
					observer.on(.next(()))
				}
			}
			return Disposables.create()
		}
		return ControlEvent(events: source)
	}
	
	var endRefreshing: Binder<(Bool,Bool)> {
		return Binder(base) { refresh, end in
			let (isEnd,isNoMore) = end
			if let footer = self.base as? MJRefreshFooter{
				if (isNoMore){
					footer.endRefreshingWithNoMoreData()
					return
				}
			}

			
			if isEnd {
				refresh.endRefreshing()
			}
		}
	}
}

extension Reactive where Base: MJRefreshFooter {
//	var endRefreshingWithNoData: Binder<Bool> {
//		return Binder(base) { refresh, isEnd in
//			if isEnd {
//				refresh.endRefreshingWithNoMoreData()
//			}
//		}
//	}
	
	var resetNoMoreData: Binder<Bool> {
		return Binder(base) { refresh, isReset in
			if isReset {
				refresh.resetNoMoreData()
			}
		}
	}
}

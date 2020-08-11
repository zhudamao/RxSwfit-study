//
//  BidSection.swift
//  Rx-Demo
//
//  Created by Zhu on 2020/5/14.
//  Copyright © 2020 Zhu. All rights reserved.
//

import Foundation
import RxDataSources

struct BidSection {
	var header:String
	var items:[BidItem]
}

extension BidSection : SectionModelType{
	typealias Item = BidItem
	
	init(original: Self, items: [Self.Item]) {
		self = original
		self.items = items;
	}
}



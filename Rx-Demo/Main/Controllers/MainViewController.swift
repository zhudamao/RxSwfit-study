//
//  MainViewController.swift
//  Rx-Demo
//
//  Created by Zhu on 2020/5/13.
//  Copyright © 2020 Zhu. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Reusable
import RxDataSources
import MBProgressHUD
import MJRefresh

class MainViewController: BaseViewController {
	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.register(cellType: BidTableViewCell.self)
		tableView.rowHeight =  UITableView.automaticDimension
		tableView.separatorInset = UIEdgeInsets.zero
		tableView.estimatedRowHeight = 60.0
		tableView.tableFooterView = UIView()
		tableView.mj_header = MJRefreshNormalHeader()
		tableView.mj_footer = MJRefreshBackNormalFooter()
		
		return tableView
	}()
	
	private lazy var dataSource:RxTableViewSectionedReloadDataSource<BidSection> = {
		let dataSource = RxTableViewSectionedReloadDataSource<BidSection> (
				configureCell: { (dataSource, tableView, indexPath, element) -> UITableViewCell in
					let cell = tableView.dequeueReusableCell(for: indexPath, cellType: BidTableViewCell.self)
					cell.bidItem = element
					cell.accessoryType = .disclosureIndicator
					return cell;
				}
//				titleForHeaderInSection: { (ds,index) in
//					return ds[index].header
//			   }
		);
		return dataSource
	}()
	
	private let disposeBag:DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
//		self.hiddenNav = true
    }
	
	override func setLayOut() {
		view.addSubview(tableView);
		tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(self.view.usnp.edges)
		}
		
//		tableView.mj_header?.rx.refReshing.subscribe(onNext: { [weak self](_)  in
//			self?.getNetWorkData()
//		}).disposed(by: disposeBag)
//
		let viewModel = MainViewModel(input: (tableView.mj_footer?.rx.refReshing.asObservable() ?? Observable.just(()),tableView.mj_header?.rx.refReshing.asObservable() ?? Observable.just(())), dependency: (disposeBag,NetworkService.shared))
		
		viewModel.tableData.asDriver().drive(tableView.rx.items) { (tableView,row,element) in
			let cell = tableView.dequeueReusableCell(for: IndexPath(row: row, section: 0), cellType: BidTableViewCell.self)
			cell.bidItem = element
			cell.accessoryType = .disclosureIndicator
			return cell;
		}.disposed(by: disposeBag)

		viewModel.endRefreshing.bind(to:(tableView.mj_footer?.rx.endRefreshing)! ).disposed(by: disposeBag)
		viewModel.restNoMoreData.bind(to: (tableView.mj_footer?.rx.resetNoMoreData)! ).disposed(by: disposeBag)
		viewModel.endRefreshing.bind(to:(tableView.mj_header?.rx.endRefreshing)! ).disposed(by: disposeBag)
		viewModel.tableData.flatMap { (items:[BidItem]) -> Observable<String> in
			return Observable.just(String(items.count) )
		}.bind(to:self.navigationItem.rx.title).disposed(by: disposeBag)
		
		self.tableView.rx.modelSelected(BidItem.self).subscribe(onNext: { [weak self] (item) in
			let dest = BidDetailViewController()
			dest.bidItem = item
			
			self?.navigationController?.pushViewController(dest, animated: true)
		}).disposed(by: disposeBag)
	}
	
	func getNetWorkData() {
		let hub = MBProgressHUD.showAdded(to: view, animated: true)
		
		let activityIndicator = ActivityIndicator()
		let data = APIProvider.rx.request(.coureDetail(1, 20, 1)).mapResponseToObjectArray(type: BidItem.self).asObservable().flatMap { (items:[BidItem]) -> Observable<[BidSection]> in
			Observable.just([BidSection(header: "1211", items: items)])
		}.trackActivity(activityIndicator)
		
		activityIndicator.asDriver().drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible).disposed(by: disposeBag)
		data.flatMap { (items:[BidSection]) -> Observable<Bool> in
			return Observable.just(items.count > 0)
		}.bind(to: hub.rx.isHidden).disposed(by: disposeBag)
		
		data.flatMap { (items:[BidSection]) -> Observable<String> in
			return Observable.just(String(items[0].items.count) )
		}.bind(to:self.navigationItem.rx.title).disposed(by: disposeBag)
		
		data.map {_ in (true,false) }.bind(to: (tableView.mj_header?.rx.endRefreshing)!).disposed(by: disposeBag)
		
		data.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag);
		
//		data.drive(tableView.rx.items) { (tableView,row,element) in
//			let cell = tableView.dequeueReusableCell(for: IndexPath(row: row, section: 0), cellType: BidTableViewCell.self)
//			cell.bidItem = element
//			cell.accessoryType = .disclosureIndicator
//			return cell;
//		}.disposed(by: disposeBag)
		
	}
	
	
	override func setNavItems() {
		self.navigationItem.title = NSLocalizedString("main", comment: "")
	}
	
}

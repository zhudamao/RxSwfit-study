//
//  MainViewController.swift
//  Rx-Demo
//
//  Created by Zhu on 2020/5/13.
//  Copyright © 2020 Zhu. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import MBProgressHUD

class LoginViewController: BaseViewController {
	private lazy var phoneTextField:UITextField = {
		let textFiled = UITextField(frame: .zero)
		textFiled.font = UIFont.systemFont(ofSize: 13.0)
		textFiled.clearButtonMode = .whileEditing
		textFiled.placeholder = NSLocalizedString("phone", comment: "")
		textFiled.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
		textFiled.keyboardType = UIKeyboardType.phonePad
		return textFiled
	}()
	
	private lazy var codeTextFiled:UITextField = {
		let textFiled = UITextField(frame: .zero)
		textFiled.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
		textFiled.font = UIFont.systemFont(ofSize: 13.0)
		textFiled.clearButtonMode = .whileEditing
		textFiled.keyboardType = UIKeyboardType.phonePad
		textFiled.placeholder = NSLocalizedString("code", comment: "")
		return textFiled
	}()
	
	private lazy var passTextField:UITextField = {
		let textFiled = UITextField(frame: .zero)
		textFiled.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
		textFiled.font = UIFont.systemFont(ofSize: 13.0)
		textFiled.clearButtonMode = .whileEditing
		textFiled.keyboardType = UIKeyboardType.asciiCapable
		textFiled.isSecureTextEntry = true
		textFiled.placeholder = NSLocalizedString("password", comment: "")
		return textFiled
	}()
	
	private lazy var codeBtn:UIButton = {
		let codeBtn = UIButton(type: .custom)
		codeBtn.setTitle(NSLocalizedString("getCode", comment: ""), for: .normal)
		codeBtn.setTitleColor(UIColor.hex(hexString: "333333"), for: .normal)
		codeBtn.setTitleColor(UIColor.hex(hexString: "dadada"), for: .disabled)
		codeBtn.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
		codeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		codeBtn.layer.cornerRadius = 3.0;
//		codeBtn.layer.borderWidth = 1.0;
//		codeBtn.layer.borderColor = UIColor.hex(hexString: "#333333").cgColor
		codeBtn.setContentHuggingPriority(UILayoutPriority.required, for: .horizontal)
		
		let image = UIImage.imageWithColor(UIColor.hex(hexString: "eeeeee"))
		codeBtn.setBackgroundImage(image, for: .normal);
		let image1 = UIImage.imageWithColor(UIColor.hex(hexString: "cccccc"))
		codeBtn.setBackgroundImage(image, for: .disabled);
		
		return codeBtn
	}()
	
	private lazy var actionBtn:UIButton = {
		let codeBtn = UIButton(type: .custom)
		codeBtn.setTitle(NSLocalizedString("login", comment: ""), for: .normal)
		codeBtn.setTitleColor(UIColor.hex(hexString: "333333"), for: .normal)
		codeBtn.setTitleColor(UIColor.hex(hexString: "dadada"), for: .disabled)
		codeBtn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
		codeBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
		codeBtn.layer.cornerRadius = 3.0;
//		codeBtn.layer.borderWidth = 1.0;
//		codeBtn.layer.borderColor = UIColor.hex(hexString: "#333333").cgColor
		
		let image = UIImage.imageWithColor(UIColor.hex(hexString: "eeeeee"))
		codeBtn.setBackgroundImage(image, for: .normal);
		let image1 = UIImage.imageWithColor(UIColor.hex(hexString: "cccccc"))
		codeBtn.setBackgroundImage(image, for: .disabled);
		
		return codeBtn
	}()
	
	private let disposeBag = DisposeBag()
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	override func setLayOut() {
		let scrollView = UIScrollView()
		view.addSubview(scrollView)
		scrollView.snp.makeConstraints { (make) in
			make.edges.equalTo(view.snp.edges)
		}
		
		let contentView = UIView()
		scrollView.addSubview(contentView)
		contentView.snp.makeConstraints { (make) in
			make.edges.equalTo(scrollView);
			make.width.equalTo(scrollView);
		}
		
		let paddingView = UIView()
		contentView.addSubview(paddingView)
		
		paddingView.snp.makeConstraints { (make) in
			make.top.equalTo(contentView).offset(160)
			make.left.equalTo(contentView).offset(30)
			make.right.equalTo(contentView).offset(-30)
		}
		
		let titleLable = UILabel()
		titleLable.font = UIFont.boldSystemFont(ofSize: 20)
		titleLable.text = NSLocalizedString("welcome", comment: "")
		
		paddingView.addSubview(titleLable)
		
		titleLable.snp.makeConstraints { (make) in
			make.top.equalTo(paddingView)
			make.centerX.equalTo(paddingView)
		}
		
		let section0 = UIView()
		paddingView.addSubview(section0)
		
		section0.snp.makeConstraints { (make) in
			make.top.equalTo(titleLable.snp.bottom).offset(20)
			make.left.right.equalToSuperview()
			make.height.equalTo(40)
		}
		{
			let titleLable = UILabel()
			titleLable.font = UIFont.systemFont(ofSize: 14.0)
			titleLable.text = NSLocalizedString("phone", comment: "")
			section0.addSubview(titleLable)
			
			titleLable.snp.makeConstraints { (make) in
				make.left.centerY.equalToSuperview()
			}
			
			section0.addSubview(self.phoneTextField)
			phoneTextField.snp.makeConstraints { (make) in
				make.centerY.right.equalToSuperview()
				make.left.equalTo(titleLable.snp.right).offset(8)
			}
		}()
		
		
		let section1 = UIView()
		paddingView.addSubview(section1)
		
		section1.snp.makeConstraints { (make) in
			make.top.equalTo(section0.snp.bottom).offset(8)
			make.left.right.equalToSuperview()
			make.height.equalTo(40)
		}
		{
			let titleLable = UILabel()
			titleLable.font = UIFont.systemFont(ofSize: 14.0)
			titleLable.text = NSLocalizedString("code", comment: "")
			titleLable.setContentHuggingPriority(UILayoutPriority.required, for: .horizontal)
			section1.addSubview(titleLable)
			
			titleLable.snp.makeConstraints { (make) in
				make.left.centerY.equalToSuperview()
			}
			
			section1.addSubview(self.codeTextFiled)
			codeTextFiled.snp.makeConstraints { (make) in
				make.centerY.equalToSuperview()
				make.left.equalTo(titleLable.snp.right).offset(8)
			}
			
			section1.addSubview(self.codeBtn)
			codeBtn.snp.makeConstraints { (make) in
				make.right.centerY.equalToSuperview()
				make.left.equalTo(codeTextFiled.snp.right).offset(10)
				make.width.equalTo(80)
			}
		}()
		
		let section2 = UIView()
		paddingView.addSubview(section2)
		
		section2.snp.makeConstraints { (make) in
			make.top.equalTo(section1.snp.bottom).offset(8)
			make.left.right.equalToSuperview()
			make.height.equalTo(40)
		}
		{
			let titleLable = UILabel()
			titleLable.font = UIFont.systemFont(ofSize: 14.0)
			titleLable.text = NSLocalizedString("password", comment: "")
			titleLable.setContentHuggingPriority(UILayoutPriority.required, for: .horizontal)
			section2.addSubview(titleLable)
			
			titleLable.snp.makeConstraints { (make) in
				make.left.centerY.equalToSuperview()
			}
			
			section2.addSubview(self.passTextField)
			passTextField.snp.makeConstraints { (make) in
				make.centerY.right.equalToSuperview()
				make.left.equalTo(titleLable.snp.right).offset(22)
			}
		}()
			
		
		paddingView.addSubview(actionBtn)
		
		actionBtn.snp.makeConstraints { (make) in
			make.top.equalTo(section2.snp.bottom).offset(40)
			make.left.right.equalTo(section2)
		}
		
		paddingView.snp.makeConstraints { (make) in
			make.bottom.equalTo(actionBtn)
		}
		
		contentView.snp.makeConstraints { (make) in
			make.bottom.equalTo(paddingView)
		}
		
		var progress:MBProgressHUD?
		actionBtn.rx.tap.subscribe(onNext: { [unowned self] (_) in
			progress = MBProgressHUD.showAdded(to: self.view, animated: true)
			self.view.endEditing(true)
		}).disposed(by: disposeBag)
		
		let viewModel = LoginViewModel(input: (phoneTextField.rx.text.orEmpty.asObservable(),
												   passTextField.rx.text.orEmpty.asObservable(),
												   codeTextFiled.rx.text.orEmpty.asObservable(),
												   codeBtn.rx.tap,
												   actionBtn.rx.tap));
		
		viewModel.codeAble.bind(to: codeBtn.rx.isEnabled).disposed(by:disposeBag)
		viewModel.actionAble.bind(to: actionBtn.rx.isEnabled).disposed(by: disposeBag)
		viewModel.timerText.bind(to: codeBtn.rx.title(for: .disabled)).disposed(by: disposeBag)
		viewModel.fixPhone.bind(to: phoneTextField.rx.text).disposed(by: disposeBag)
		viewModel.fixCode.bind(to: codeTextFiled.rx.text).disposed(by: disposeBag)
		viewModel.loginRespone.subscribe(onNext: { [weak self](response:[String : Any]) in
			progress?.hide(animated: true)
			let loginCtlr = LoginSuccessController()
			loginCtlr.successInfo = LoginInfo(phone: response["phone"] as? String ?? "" , code: response["code"] as? String ?? "", passwd: response["pass"] as? String ?? "")
			self?.navigationController?.pushViewController(loginCtlr, animated: true)
			},onError: { error in
				debugPrint(error.localizedDescription)
		}).disposed(by: disposeBag)

		
	}
	
	override func setNavItems() {
		self.navigationItem.title = NSLocalizedString("login", comment: "")
	}
	
	
}

//
//  ViewController.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/6.
//

import UIKit

protocol LoginViewControllerDisplayLogic: AnyObject {
	func showLoginFailureView(viewModel: String)
	func showLoginSuccessView() 
}

class LoginViewController: UIViewController {
//	let interactor: LoginViewControllerBusinessLogic
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
	}
	
//	init(interactor: LoginViewControllerBusinessLogic) {
//		self.interactor = interactor
//		super.init(nibName: nil, bundle: nil)
//	}
//
//	required init?(coder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
}

extension LoginViewController: LoginViewControllerDisplayLogic {
	func showLoginFailureView(viewModel: String) {
		
	}
	
	func showLoginSuccessView() {
		
	}
}


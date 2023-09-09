//
//  LoginViewControllerRouter.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/9.
//

import UIKit

protocol LoginViewControllerRoutingLogic: AnyObject {
	func showLoginFailureView(viewModel: String)
	func showLoginSuccessView()
	func dismiss()
}

class LoginViewControllerRouter: LoginViewControllerRoutingLogic {
	weak var sourceView: UIViewController?
	
	func showLoginFailureView(viewModel: String) {
		let action = UIAlertAction(title: "OK", style: .destructive) { _ in
			self.dismiss()
		}
		let alertController
			= UIAlertController(title: "Login Failure",
								message: viewModel,
								preferredStyle: .alert)
		alertController.addAction(action)
		sourceView?.present(alertController, animated: true)
	}
	
	func showLoginSuccessView() {
		let action = UIAlertAction(title: "OK", style: .cancel) { _ in
			self.dismiss()
		}
		let alertController
			= UIAlertController(title: "Login Success",
								message: nil,
								preferredStyle: .alert)
		alertController.addAction(action)
		sourceView?.present(alertController, animated: true)
	}
	
	func dismiss() {
		sourceView?.dismiss(animated: true)
	}
	
}

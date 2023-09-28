//
//  SignUpViewControllerRoutingLogic.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/28.
//

import UIKit

protocol SignUpViewControllerRoutingLogic: AnyObject {
	func showSignUpFailureView(viewModel: String)
	func showSignUpSuccessView()
	func dismiss()
	func pop()
}

class SignUpViewControllerRouter: SignUpViewControllerRoutingLogic {
	weak var sourceView: UIViewController?
	
	func showSignUpFailureView(viewModel: String) {
		let action = UIAlertAction(title: "OK", style: .default)
		let alertController = UIAlertController(
			title: "Failure",
			message: viewModel,
			preferredStyle: .alert
		)
		
		alertController.addAction(action)
		sourceView?.present(alertController, animated: true)
	}
	
	func showSignUpSuccessView() {
		let action = UIAlertAction(title: "OK", style: .cancel) { _ in
			self.dismiss()
		}
		let alertController = UIAlertController(
			title: "Success",
			message: nil,
			preferredStyle: .alert
		)
		
		alertController.addAction(action)
		sourceView?.present(alertController, animated: true)
	}
	
	func dismiss() {
		sourceView?.dismiss(animated: true)
	}
	
	func pop() {
		sourceView?.navigationController?.popViewController(animated: true)
	}
}

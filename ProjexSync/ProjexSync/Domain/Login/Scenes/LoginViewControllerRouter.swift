//
//  AuthViewControllerRouter.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/9.
//

import UIKit

protocol AuthViewControllerRoutingLogic: AnyObject {
	func showLoginFailureView(viewModel: String)
	func showLoginSuccessView()
	func dismiss()
    func navigateToSignUpPage()
}

class AuthViewControllerRouter: AuthViewControllerRoutingLogic {
	weak var sourceView: UIViewController?
	
	func showLoginFailureView(viewModel: String) {
		let action = UIAlertAction(title: "OK", style: .default)
		let alertController = UIAlertController(
			title: "Failure",
			message: viewModel,
			preferredStyle: .alert
		)
		
		alertController.addAction(action)
		sourceView?.present(alertController, animated: true)
	}
	
	func showLoginSuccessView() {
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
    
    func navigateToSignUpPage() {
        let vc = AuthSceneFactory().makeSignupScene()
        sourceView?.navigationController?.pushViewController(vc, animated: true)
    }
	
}

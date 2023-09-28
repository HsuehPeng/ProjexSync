//
//  LoginPresenter.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/8.
//

import Foundation

protocol AuthViewControllerPresentationLogic: AnyObject {
	func showLoginFailure(message: String)
	func showLoginSuccess()
	func loginLoadingIndicator(isLoading: Bool)
}

class AuthControllerPresenter: AuthViewControllerPresentationLogic {
	weak var viewController: AuthDisplayLogic?
	
	func showLoginFailure(message: String) {
		viewController?.showAutnFailureView(viewModel: message)
	}
	
	func showLoginSuccess() {
		viewController?.showAuthSuccessView()
	}
	
	func loginLoadingIndicator(isLoading: Bool) {
		viewController?.loadingIndicator(shouldShow: isLoading)
	}
	
	
}

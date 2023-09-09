//
//  LoginInteractor.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/8.
//

import Foundation

protocol LoginViewControllerBusinessLogic: AnyObject {
	func login()
}

class LoginViewControllerInteractor {
	let presenter: LoginViewControllerPresentationLogic
	let loginService: LoginService
	
	init(presenter: LoginViewControllerPresentationLogic, loginService: LoginService) {
		self.presenter = presenter
		self.loginService = loginService
	}
}

extension LoginViewControllerInteractor: LoginViewControllerBusinessLogic {
	func login() {
		presenter.showLoginLoadingIndicator(isLoading: true)
		
		loginService.login { [weak self] error in
			guard let self = self else { return }
			
			if let error = error {
				self.presenter.showLoginFailure(message: error.localizedDescription)
			} else {
				self.presenter.showLoginSuccess()
			}
			
			self.presenter.showLoginLoadingIndicator(isLoading: false)
		}
	}
}

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

class LoginInteractor {
	let presenter: LoginViewControllerPresentationLogic
	let loginService: LoginService
	
	init(presenter: LoginViewControllerPresentationLogic, loginService: LoginService) {
		self.presenter = presenter
		self.loginService = loginService
	}
}

extension LoginInteractor: LoginViewControllerBusinessLogic {
	func login() {
		presenter.showLoginLoadingIndicator(isLoading: true)
		
		loginService.login { [weak self] error in
			guard let self = self else { return }
			
			if let _ = error {
				self.presenter.showLoginFailure()
			} else {
				self.presenter.showLoginSuccess()
			}
			
			self.presenter.showLoginLoadingIndicator(isLoading: false)
		}
	}
}

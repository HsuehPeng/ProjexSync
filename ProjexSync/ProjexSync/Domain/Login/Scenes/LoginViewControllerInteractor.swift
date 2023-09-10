//
//  LoginInteractor.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/8.
//

import Foundation

protocol LoginViewControllerBusinessLogic: AnyObject {
	func loginWith(email: String?, password: String?)
}

class LoginViewControllerInteractor {
	let presenter: LoginViewControllerPresentationLogic
	let loginClient: EmailLoginClient
	
	init(presenter: LoginViewControllerPresentationLogic, loginClient: EmailLoginClient) {
		self.presenter = presenter
		self.loginClient = loginClient
	}
}

extension LoginViewControllerInteractor: LoginViewControllerBusinessLogic {
	func loginWith(email: String?, password: String?) {
		presenter.loginLoadingIndicator(isLoading: true)
		
		loginClient.login(email: email ?? "", password: password ?? "") { [weak self] result in
			guard let self = self else { return }
			
			switch result {
			case .success:
				self.presenter.showLoginSuccess()
			case .failure(let error):
				self.presenter.showLoginFailure(message: error.localizedDescription)
			}
			
			self.presenter.loginLoadingIndicator(isLoading: false)
		}
	}
}

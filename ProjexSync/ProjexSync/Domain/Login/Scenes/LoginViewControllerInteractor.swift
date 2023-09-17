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
	private let presenter: LoginViewControllerPresentationLogic
	private let loginWorker: LoginLogic
	
	init(presenter: LoginViewControllerPresentationLogic, loginWorker: LoginLogic) {
		self.presenter = presenter
		self.loginWorker = loginWorker
	}
}

extension LoginViewControllerInteractor: LoginViewControllerBusinessLogic {
	func loginWith(email: String?, password: String?) {
		presenter.loginLoadingIndicator(isLoading: true)
		
		loginWorker.login(email: email, password: password) { [weak self] result in
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

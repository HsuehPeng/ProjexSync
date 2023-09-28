//
//  LoginInteractor.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/8.
//

import Foundation

protocol AuthViewControllerBusinessLogic: AnyObject {
	func authWith(email: String?, password: String?)
}

class AuthViewControllerInteractor {
	private let presenter: AuthViewControllerPresentationLogic
	private let loginWorker: AuthLogic
	private var isAuthed = false
	
	init(presenter: AuthViewControllerPresentationLogic, loginWorker: AuthLogic) {
		self.presenter = presenter
		self.loginWorker = loginWorker
	}
}

extension AuthViewControllerInteractor: AuthViewControllerBusinessLogic {
    
	func authWith(email: String?, password: String?) {
		guard !isAuthed else { return }
		
		isAuthed = true
		presenter.loginLoadingIndicator(isLoading: true)
		
		loginWorker.auth(email: email, password: password) { [weak self] result in
			guard let self = self else { return }
			
			switch result {
			case .success:
				self.presenter.showLoginSuccess()
			case .failure(let error):
				self.presenter.showLoginFailure(message: error.localizedDescription)
			}
			
            isAuthed = false
			self.presenter.loginLoadingIndicator(isLoading: false)
		}
	}
}

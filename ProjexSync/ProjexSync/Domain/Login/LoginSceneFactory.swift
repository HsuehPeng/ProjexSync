//
//  LoginSceneFactory.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/8.
//

import Foundation
import FirebaseAuth

class LoginSceneFactory {
	func makeLoginScene() -> LoginViewController {
		let presenter = LoginViewControllerPresenter()
		let loginWorker = LoginWorker(emailLoginClient: Auth.auth(), emailPasswordValidator: EmailPasswordValidator())
		let interactor = LoginViewControllerInteractor(presenter: presenter, loginWorker: loginWorker)
		let loginViewController = LoginViewController(interactor: interactor)
		let router = LoginViewControllerRouter()
		loginViewController.router = router
		router.sourceView = loginViewController
		presenter.viewController = loginViewController

		return loginViewController
	}
}

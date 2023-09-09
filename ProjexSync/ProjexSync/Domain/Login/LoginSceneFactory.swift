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
		let loginService = EmailPasswordLoginService(authClient: Auth.auth(), email: "", password: "")
		let presenter = LoginViewControllerPresenter()
		let interactor = LoginViewControllerInteractor(presenter: presenter, loginService: loginService)
		let loginViewController = LoginViewController(interactor: interactor)
		let router = LoginViewControllerRouter()
		loginViewController.router = router
		router.sourceView = loginViewController
		presenter.viewController = loginViewController

		return loginViewController
	}
}

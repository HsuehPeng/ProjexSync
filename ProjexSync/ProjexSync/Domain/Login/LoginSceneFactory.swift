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
		return LoginViewController(interactor: interactor)
	}
}

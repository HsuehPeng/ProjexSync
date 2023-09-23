//
//  LoginSceneFactory.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/8.
//

import Foundation
import FirebaseAuth

class AuthSceneFactory {
	func makeLoginScene() -> LoginViewController {
		let presenter = AuthControllerPresenter()
        let loginWorker: AuthLogic = AuthWorker(client: LoginManager.shared, emailPasswordValidator: EmailPasswordValidator())
		let interactor = AuthViewControllerInteractor(presenter: presenter, loginWorker: loginWorker)
		let loginViewController = LoginViewController(interactor: interactor)
		let router = AuthViewControllerRouter()
		loginViewController.router = router
		router.sourceView = loginViewController
		presenter.viewController = loginViewController

		return loginViewController
	}
    
    func makeSignupScene() -> SignupViewController {
        let presenter = AuthControllerPresenter()
        let signupWorker: AuthLogic = AuthWorker(client: SignupManager.shared, emailPasswordValidator: EmailPasswordValidator())
        let interactor = AuthViewControllerInteractor(presenter: presenter, loginWorker: signupWorker)
        let signupViewController = SignupViewController(interactor: interactor)
        let router = AuthViewControllerRouter()
        signupViewController.router = router
        router.sourceView = signupViewController
        presenter.viewController = signupViewController

        return signupViewController
    }
}

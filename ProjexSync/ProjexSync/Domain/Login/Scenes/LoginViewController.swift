//
//  ViewController.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/6.
//

import UIKit

protocol LoginViewControllerDisplayLogic: AnyObject {
	func showLoginFailureView(viewModel: String)
	func showLoginSuccessView()
	func loginLoadingIndicator(shouldShow: Bool)
}

class LoginViewController: UIViewController {
	private let interactor: LoginViewControllerBusinessLogic
	var router: LoginViewControllerRoutingLogic?
	lazy var contentView = LoginViewControllerView()
	
	// MARK: - LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view = contentView
		contentView.signInButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
	}
	
	init(interactor: LoginViewControllerBusinessLogic) {
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc func didTapSignInButton() {
		interactor.loginWith(email: contentView.emailTextField.text, password: contentView.passwordTextField.text)
	}
}

extension LoginViewController: LoginViewControllerDisplayLogic {
	func showLoginFailureView(viewModel: String) {
		router?.showLoginFailureView(viewModel: viewModel)
	}
	
	func showLoginSuccessView() {
		router?.showLoginSuccessView()
	}
	
	func loginLoadingIndicator(shouldShow: Bool) {
		shouldShow ? contentView.loadingIndicator.startAnimating() : contentView.loadingIndicator.stopAnimating()
	}
}

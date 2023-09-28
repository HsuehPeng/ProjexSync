//
//  SignupViewController.swift
//  ProjexSync
//
//  Created by Boray Chen on 2023/9/23.
//

import UIKit

class SignupViewController: UIViewController {
	private let interactor: AuthViewControllerBusinessLogic
	var router: SignUpViewControllerRoutingLogic?
	lazy var contentView = AuthViewControllerView()
	
	// MARK: - LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupContentView()
		contentView.titleLabel.text = "Sign Up"
		contentView.authButton.setTitle("Sign Up", for: .normal)
		contentView.noticeLabel.text = "Already have an account?"
		contentView.actionButton.setTitle("Log In", for: .normal)
		contentView.actionButton.addTarget(self, action: #selector(didTapLogInButton), for: .touchUpInside)
		contentView.authButton.addTarget(self, action: #selector(didTapAuthSignupButton), for: .touchUpInside)
	}
	
	init(interactor: AuthViewControllerBusinessLogic) {
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupContentView() {
		contentView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(contentView)
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: view.topAnchor),
			contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	@objc func didTapAuthSignupButton(_ sender: UIButton) {
		interactor.authWith(email: contentView.emailTextField.text, password: contentView.passwordTextField.text)
	}

	@objc func didTapLogInButton(_ sender: UIButton) {
		router?.pop()
	}
}

extension SignupViewController: AuthDisplayLogic {
	func showAutnFailureView(viewModel: String) {
		router?.showSignUpFailureView(viewModel: viewModel)
	}
	
	func showAuthSuccessView() {
		router?.showSignUpSuccessView()
	}
	
	func loadingIndicator(shouldShow: Bool) {
		shouldShow ? contentView.loadingIndicator.startAnimating() : contentView.loadingIndicator.stopAnimating()
	}
}

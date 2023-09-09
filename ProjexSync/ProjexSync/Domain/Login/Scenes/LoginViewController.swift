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
	let interactor: LoginViewControllerBusinessLogic
	var router: LoginViewControllerRoutingLogic?
	
	// MARK: - UI Elements
	
	let welcomeLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Hi, Welcome Back!"
		label.textAlignment = .center
		return label
	}()
	
	let signinTitleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Sign In"
		label.textAlignment = .center
		return label
	}()
	
	lazy var signInButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
		button.setTitle("Sign In", for: .normal)
		button.backgroundColor = .red
		return button
	}()
	
	let emailTextField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.placeholder = "Enter your email address"
		return textField
	}()
	
	let passwordTextField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.placeholder = "Enter your password"
		return textField
	}()
	
	let loadingIndicator: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView(style: .large)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.hidesWhenStopped = true
		view.color = .black
		return view
	}()
	
	// MARK: - LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		configureLayout()
	}
	
	init(interactor: LoginViewControllerBusinessLogic) {
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc func didTapSignInButton() {
		interactor.login()
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
		shouldShow ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
	}
}

// MARK: - Layout

extension LoginViewController {
	private func configureLayout() {
		view.addSubview(welcomeLabel)
		view.addSubview(signinTitleLabel)
		view.addSubview(emailTextField)
		view.addSubview(passwordTextField)
		view.addSubview(signInButton)
		view.addSubview(loadingIndicator)
		
		NSLayoutConstraint.activate([
			welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 76),
			welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 62),
			welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -62),
		])
		
		NSLayoutConstraint.activate([
			signinTitleLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 8),
			signinTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 62),
			signinTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -62),
		])
		
		NSLayoutConstraint.activate([
			emailTextField.topAnchor.constraint(equalTo: signinTitleLabel.bottomAnchor, constant: 151),
			emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
			emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
			emailTextField.heightAnchor.constraint(equalToConstant: 52)
		])
		
		NSLayoutConstraint.activate([
			passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 46),
			passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
			passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
			passwordTextField.heightAnchor.constraint(equalToConstant: 52)
		])
		
		NSLayoutConstraint.activate([
			signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 32),
			signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
			signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
			signInButton.heightAnchor.constraint(equalToConstant: 56)
		])
		
		NSLayoutConstraint.activate([
			loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
		])
	}
}


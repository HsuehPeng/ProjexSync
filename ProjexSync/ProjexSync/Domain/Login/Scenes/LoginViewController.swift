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
	
	// MARK: - UI Elements
	
	let signinTitleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Sign In"
		label.textAlignment = .center
		label.font = FontConstants.BODY_XL_BOLD
		label.textColor = ColorConstants.additionalBlack
		return label
	}()
	
	let emailAddressLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Email Address"
		label.font = FontConstants.BODY_M_MEDIUM
		label.textColor = ColorConstants.grayscale70
		return label
	}()
	
	let emailTextField: BaseTextField = {
		let textField = BaseTextField(placeHolder: "Enter your email address")
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	
	let passwordLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Password"
		label.font = FontConstants.BODY_M_MEDIUM
		label.textColor = ColorConstants.grayscale70
		return label
	}()
	
	let passwordTextField: HidableTextField = {
		let textField = HidableTextField(placeHolder: "Enter your password")
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	
	lazy var signInButton: ProjexSyncButton = {
		let button = ProjexSyncButton(type: .primary, size: .large)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
		button.setTitle("Sign In", for: .normal)
		return button
	}()
	
	lazy var firstLineView = makeLineView()
	
	let continueWithLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Or continue with"
		label.font = FontConstants.BODY_M_SEMIBOLD
		label.textColor = ColorConstants.additionalGray
		return label
	}()
	
	lazy var secondLineView = makeLineView()
	
	let continueWithHStack: UIStackView = {
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .horizontal
		view.spacing = 12
		view.alignment = .center
		return view
	}()
	
	let noAccountLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Don’t have an account?"
		label.font = FontConstants.BODY_L_SEMIBOLD
		label.textColor = ColorConstants.textGrey
		return label
	}()
	
	let signUpButton: ProjexSyncButton = {
		let button = ProjexSyncButton(type: .tertiary, size: .large)
		button.setTitle("Sign Up", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	let signUpHsStack: UIStackView = {
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .horizontal
		view.spacing = 2
		return view
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
		interactor.loginWith(email: emailTextField.text, password: passwordTextField.text)
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
		view.addSubview(signinTitleLabel)
		view.addSubview(emailAddressLabel)
		view.addSubview(emailTextField)
		view.addSubview(passwordLabel)
		view.addSubview(passwordTextField)
		view.addSubview(signInButton)
		view.addSubview(continueWithHStack)
		view.addSubview(signUpHsStack)
		view.addSubview(loadingIndicator)
		
		NSLayoutConstraint.activate([
			signinTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
			signinTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
		
		NSLayoutConstraint.activate([
			emailAddressLabel.topAnchor.constraint(equalTo: signinTitleLabel.bottomAnchor, constant: 60),
			emailAddressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
			emailAddressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
		])
		
		NSLayoutConstraint.activate([
			emailTextField.topAnchor.constraint(equalTo: emailAddressLabel.bottomAnchor, constant: 8),
			emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
			emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
			emailTextField.heightAnchor.constraint(equalToConstant: 52)
		])
		
		NSLayoutConstraint.activate([
			passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
			passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
			passwordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
		])
		
		NSLayoutConstraint.activate([
			passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
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
			firstLineView.widthAnchor.constraint(equalToConstant: 62),
			firstLineView.heightAnchor.constraint(equalToConstant: 1)
		])
		
		NSLayoutConstraint.activate([
			secondLineView.widthAnchor.constraint(equalToConstant: 62),
			secondLineView.heightAnchor.constraint(equalToConstant: 1)
		])
		
		continueWithHStack.addArrangedSubview(firstLineView)
		continueWithHStack.addArrangedSubview(continueWithLabel)
		continueWithHStack.addArrangedSubview(secondLineView)
		NSLayoutConstraint.activate([
			continueWithHStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			continueWithHStack.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 32),
			continueWithHStack.heightAnchor.constraint(equalToConstant: 22)
		])
		
		signUpHsStack.addArrangedSubview(noAccountLabel)
		signUpHsStack.addArrangedSubview(signUpButton)
		NSLayoutConstraint.activate([
			signUpHsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			signUpHsStack.topAnchor.constraint(equalTo: continueWithHStack.bottomAnchor, constant: 32),
			signUpHsStack.heightAnchor.constraint(equalToConstant: 24)
		])
		
		NSLayoutConstraint.activate([
			loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
		])
		
	}
	
	private func makeLineView() -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = ColorConstants.additionalGray
		return view
	}
}


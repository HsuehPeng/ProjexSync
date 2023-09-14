//
//  LoginViewControllerView.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/12.
//

import UIKit

final class LoginViewControllerView: ProgrammaticView {
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
		button.setTitle("Sign In", for: .normal)
		return button
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
	
	override func configure() {
		backgroundColor = .white
		emailTextField.delegate = self
		passwordTextField.delegate = self
		
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapSelf))
		addGestureRecognizer(tapGestureRecognizer)
	}
	
	override func setupConstraint() {
		addSubview(signinTitleLabel)
		addSubview(emailAddressLabel)
		addSubview(emailTextField)
		addSubview(passwordLabel)
		addSubview(passwordTextField)
		addSubview(signInButton)
		addSubview(signUpHsStack)
		addSubview(loadingIndicator)
		
		NSLayoutConstraint.activate([
			signinTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 72),
			signinTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
		])
		
		NSLayoutConstraint.activate([
			emailAddressLabel.topAnchor.constraint(equalTo: signinTitleLabel.bottomAnchor, constant: 60),
			emailAddressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
			emailAddressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
		])
		
		NSLayoutConstraint.activate([
			emailTextField.topAnchor.constraint(equalTo: emailAddressLabel.bottomAnchor, constant: 8),
			emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
			emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
			emailTextField.heightAnchor.constraint(equalToConstant: 52)
		])
		
		NSLayoutConstraint.activate([
			passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
			passwordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
			passwordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
		])
		
		NSLayoutConstraint.activate([
			passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
			passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
			passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
			passwordTextField.heightAnchor.constraint(equalToConstant: 52)
		])
		
		NSLayoutConstraint.activate([
			signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 32),
			signInButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
			signInButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
			signInButton.heightAnchor.constraint(equalToConstant: 56)
		])
		
		signUpHsStack.addArrangedSubview(noAccountLabel)
		signUpHsStack.addArrangedSubview(signUpButton)
		NSLayoutConstraint.activate([
			signUpHsStack.centerXAnchor.constraint(equalTo: centerXAnchor),
			signUpHsStack.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 32),
			signUpHsStack.heightAnchor.constraint(equalToConstant: 24)
		])
		
		NSLayoutConstraint.activate([
			loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
			loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
		])
	}
	
	@objc func didTapSelf() {
		endEditing(true)
	}
}

extension LoginViewControllerView: UITextFieldDelegate {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		guard let textField = textField as? BaseTextField else { return true }
		let currentText = textField.text ?? ""
		let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
		
		if updatedText.isEmpty {
			textField.setEmptyUI()
		} else {
			textField.setFilledUI()
		}
		
		return true
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		switch textField {
		case emailTextField:
			emailTextField.resignFirstResponder()
			passwordTextField.becomeFirstResponder()
		case passwordTextField:
			passwordTextField.resignFirstResponder()
		default:
			break
		}
		
		return true
	}
}

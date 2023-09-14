//
//  LoginViewControllerView.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/12.
//

import UIKit

final class LoginViewControllerView: ProgrammaticView {
	let scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		return scrollView
	}()
	
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
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
	override func configure() {
		backgroundColor = .white
		emailTextField.delegate = self
		passwordTextField.delegate = self
		
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapSelf))
		addGestureRecognizer(tapGestureRecognizer)
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

	}
	
	override func setupConstraint() {
		addSubview(scrollView)
		scrollView.addSubview(signinTitleLabel)
		scrollView.addSubview(emailAddressLabel)
		scrollView.addSubview(emailTextField)
		scrollView.addSubview(passwordLabel)
		scrollView.addSubview(passwordTextField)
		scrollView.addSubview(signInButton)
		scrollView.addSubview(signUpHsStack)
		addSubview(loadingIndicator)
		
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
		])
		
		NSLayoutConstraint.activate([
			signinTitleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 72),
			signinTitleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
			signinTitleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
			signinTitleLabel.widthAnchor.constraint(equalTo: widthAnchor)
		])
		
		NSLayoutConstraint.activate([
			emailAddressLabel.topAnchor.constraint(equalTo: signinTitleLabel.bottomAnchor, constant: 60),
			emailAddressLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
			emailAddressLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
		])
		
		NSLayoutConstraint.activate([
			emailTextField.topAnchor.constraint(equalTo: emailAddressLabel.bottomAnchor, constant: 8),
			emailTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
			emailTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
			emailTextField.heightAnchor.constraint(equalToConstant: 52)
		])
		
		NSLayoutConstraint.activate([
			passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
			passwordLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
			passwordLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
		])
		
		NSLayoutConstraint.activate([
			passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
			passwordTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
			passwordTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
			passwordTextField.heightAnchor.constraint(equalToConstant: 52)
		])
		
		NSLayoutConstraint.activate([
			signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 32),
			signInButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
			signInButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
			signInButton.heightAnchor.constraint(equalToConstant: 56)
		])
		
		signUpHsStack.addArrangedSubview(noAccountLabel)
		signUpHsStack.addArrangedSubview(signUpButton)
		NSLayoutConstraint.activate([
			signUpHsStack.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 32),
			signUpHsStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
			signUpHsStack.heightAnchor.constraint(equalToConstant: 24),
			signUpHsStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16)
		])
		
		NSLayoutConstraint.activate([
			loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
			loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
		])
	}

	@objc func keyboardWillShow(_ notification: Notification) {
		if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
			scrollView.contentInset.bottom = keyboardFrame.height
			scrollView.verticalScrollIndicatorInsets.bottom = keyboardFrame.height
			
			if let activeTextField = findActiveTextField() {
				let textFieldFrame = activeTextField.convert(activeTextField.bounds, to: scrollView)
				if !scrollView.bounds.contains(textFieldFrame) {
					scrollView.scrollRectToVisible(textFieldFrame, animated: true)
				}
			}
		}
	}
	
	@objc func keyboardWillHide(_ notification: Notification) {
		scrollView.contentInset = .zero
		scrollView.scrollIndicatorInsets = .zero
	}
	
	@objc func didTapSelf() {
		endEditing(true)
	}
	
	private func findActiveTextField() -> UITextField? {
		if emailTextField.isFirstResponder {
			return emailTextField
		} else if passwordTextField.isFirstResponder {
			return passwordTextField
		}
		return nil
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

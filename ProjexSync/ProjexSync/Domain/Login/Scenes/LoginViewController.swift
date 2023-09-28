//
//  ViewController.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/6.
//

import UIKit

protocol AuthDisplayLogic: AnyObject {
	func showAutnFailureView(viewModel: String)
    // should change to dismissSelf later
	func showAuthSuccessView()
	func loadingIndicator(shouldShow: Bool)
}

class LoginViewController: UIViewController {
	private let interactor: AuthViewControllerBusinessLogic
	var router: AuthViewControllerRoutingLogic?
	lazy var contentView = AuthViewControllerView()
	
	// MARK: - LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
        setupContentView()
		contentView.authButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        contentView.actionButton.addTarget(self, action: #selector(didTapSignupButton), for: .touchUpInside)
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
    
	@objc func didTapSignInButton(_ sender: UIButton) {
        if sender.titleLabel?.text == "Sign In" {
            interactor.authWith(email: contentView.emailTextField.text, password: contentView.passwordTextField.text)
        }
	}

    @objc func didTapSignupButton(_ sender: UIButton) {
        if sender.titleLabel?.text == "Sign Up" {
            router?.navigateToSignUpPage()
        }
    }
}

extension LoginViewController: AuthDisplayLogic {
	func showAutnFailureView(viewModel: String) {
		router?.showLoginFailureView(viewModel: viewModel)
	}
	
	func showAuthSuccessView() {
		router?.showLoginSuccessView()
	}
	
	func loadingIndicator(shouldShow: Bool) {
		shouldShow ? contentView.loadingIndicator.startAnimating() : contentView.loadingIndicator.stopAnimating()
	}
}

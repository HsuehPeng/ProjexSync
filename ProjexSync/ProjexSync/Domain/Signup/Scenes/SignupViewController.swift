//
//  SignupViewController.swift
//  ProjexSync
//
//  Created by Boray Chen on 2023/9/23.
//

import UIKit

class SignupViewController: LoginViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.titleLabel.text = "Sign Up"
        contentView.authButton.setTitle("Sign Up", for: .normal)
        contentView.authButton.addTarget(self, action: #selector(didTapAuthSignupButton), for: .touchUpInside)
        contentView.noticeLabel.text = "Already have an account?"
        contentView.actionButton.setTitle("Log In", for: .normal)
        contentView.actionButton.addTarget(self, action: #selector(didTapLogInButton), for: .touchUpInside)
    }

    @objc func didTapAuthSignupButton(_ sender: UIButton) {
        if sender.titleLabel?.text == "Sign Up" {
            print("Sign Up")
        }
    }
    
    @objc func didTapLogInButton(_ sender: UIButton) {
        if sender.titleLabel?.text == "Log In" {
            navigationController?.popViewController(animated: true)
        }
    }
}

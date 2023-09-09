//
//  LoginPresenter.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/8.
//

import Foundation

protocol LoginViewControllerPresentationLogic: AnyObject {
	func showLoginFailure(viewModel: LoginFailureViewModel)
	func showLoginSuccess(viewModel: LoginSuccessViewModel)
}

class LoginPresenter {

}

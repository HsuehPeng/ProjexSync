//
//  RootTabBarRouter.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/8.
//

import UIKit

class RootTabBarRouter {
	weak var source: UIViewController?
	
	private let loginSceneFactory: LoginSceneFactory
	
	init(loginSceneFactory: LoginSceneFactory) {
		self.loginSceneFactory = loginSceneFactory
	}
}

extension RootTabBarRouter {
	func presentLoginScene() {
		let loginVC = loginSceneFactory.makeLoginScene()
		source?.modalPresentationStyle = .fullScreen
		source?.present(loginVC, animated: true)
	}
}

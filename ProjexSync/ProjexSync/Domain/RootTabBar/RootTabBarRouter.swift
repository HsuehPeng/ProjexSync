//
//  RootTabBarRouter.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/8.
//

import UIKit

class RootTabBarRouter {
	weak var source: UIViewController?
	
	private let sceneFactory: AuthSceneFactory
	
	init(sceneFactory: AuthSceneFactory) {
		self.sceneFactory = sceneFactory
	}
}

extension RootTabBarRouter {
	func presentLoginScene() {
		let loginVC = sceneFactory.makeLoginScene()
        let nav = UINavigationController(rootViewController: loginVC)
        source?.modalPresentationStyle = .fullScreen
		source?.present(nav, animated: true)
	}
}

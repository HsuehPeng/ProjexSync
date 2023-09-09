//
//  RootTabBarController.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/8.
//

import UIKit
import FirebaseAuth

class RootTabBarController: UITabBarController {
	var router: RootTabBarRouter?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		presentLogin()
	}
	
	init(viewControllers: [UIViewController]) {
		super.init(nibName: nil, bundle: nil)
		self.viewControllers = viewControllers
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension RootTabBarController {
	private func presentLogin() {
		DispatchQueue.main.async {
			self.router?.presentLoginScene()
		}
	}
}

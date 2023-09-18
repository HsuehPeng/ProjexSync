//
//  HomePageViewControllerFactory.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/18.
//

import Foundation

final class HomePageViewControllerFactory {
	static func makeHomePageScene() -> HomePageViewController {
		let vc = HomePageViewController()
		vc.title = "Home"
		return vc
	}
}

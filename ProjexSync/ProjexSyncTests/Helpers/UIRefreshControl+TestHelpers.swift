//
//  UIRefreshControl+TestHelpers.swift
//  ProjexSyncTests
//
//  Created by Hsueh Peng Tseng on 2023/9/19.
//

import UIKit

extension UIRefreshControl {
	func simulatePullToRefresh() {
		simulate(event: .valueChanged)
	}
}

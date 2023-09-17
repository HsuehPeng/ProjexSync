//
//  UIButton+TestHelpers.swift
//  ProjexSyncTests
//
//  Created by Hsueh Peng Tseng on 2023/9/9.
//

import UIKit

extension UIButton {
	func simulateTap() {
		simulate(event: .touchUpInside)
	}
}

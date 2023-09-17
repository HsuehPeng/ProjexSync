//
//  ProgrammaticView.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/12.
//

import UIKit

class ProgrammaticView: UIView {
	@available(*, unavailable, message: "Don't use init(coder:), override init(frame:) instead")
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		translatesAutoresizingMaskIntoConstraints = false
		configure()
		setupConstraint()
	}
	
	func configure() {}

	func setupConstraint() {}
}

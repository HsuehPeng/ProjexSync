//
//  PrimaryButton.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/12.
//

import UIKit

class PrimaryButton: UIButton {
	enum ButtonSize {
		case small
		case medium
		case large
	}
	
	convenience init(size: ButtonSize) {
		self.init()
		configure(size: size)
	}
	
	private func configure(size: ButtonSize) {
		backgroundColor = ColorConstants.primary
		setTitleColor(ColorConstants.additionalWhite, for: .normal)
		
		switch size {
		case .small:
			titleLabel?.font = FontConstants.BODY_S_SEMIBOLD
			layer.cornerRadius = 12
		case .medium:
			titleLabel?.font = FontConstants.BODY_M_SEMIBOLD
			layer.cornerRadius = 20
		case .large:
			titleLabel?.font = FontConstants.BODY_L_SEMIBOLD
			layer.cornerRadius = 24
		}
	}
}

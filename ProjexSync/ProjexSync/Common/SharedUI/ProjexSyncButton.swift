//
//  BaseButton.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/12.
//

import UIKit

class ProjexSyncButton: UIButton {
	enum ButtonSize {
		case small
		case medium
		case large
	}
	
	enum ButtonType {
		case primary
		case secondary
		case tertiary
		case disable
		case state
	}
	
	convenience init(type: ButtonType, size: ButtonSize) {
		self.init()
		configure(type: type, size: size)
	}
	
	private func configure(type: ButtonType, size: ButtonSize) {
		switch type {
		case .primary:
			backgroundColor = ColorConstants.primary
			setTitleColor(ColorConstants.additionalWhite, for: .normal)
		case .secondary:
			backgroundColor = ColorConstants.additionalWhite
			setTitleColor(ColorConstants.primary, for: .normal)
		case .tertiary:
			backgroundColor = .clear
			setTitleColor(ColorConstants.primary, for: .normal)
		case .disable:
			backgroundColor = ColorConstants.grayscale20
			setTitleColor(ColorConstants.grayscale60, for: .normal)
		case .state:
			backgroundColor = ColorConstants.alertSuccess
			setTitleColor(ColorConstants.grayscale10, for: .normal)
		}
		
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

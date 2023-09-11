//
//  InputTextField.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/11.
//

import UIKit

class InputTextField: UITextField {
	convenience init(placeHolder: String) {
		self.init()
		
		let attributes: [NSAttributedString.Key: Any] = [
			.font: FontConstants.BODY_L_MEDIUM,
			.foregroundColor: ColorConstants.grayscale60
		]
		let attributedPlaceHolderString = NSAttributedString(string: placeHolder, attributes: attributes)
		attributedPlaceholder = attributedPlaceHolderString
		configure()
	}
	
	private func configure() {
		layer.cornerRadius = 24
		backgroundColor = ColorConstants.secondary
	}
}

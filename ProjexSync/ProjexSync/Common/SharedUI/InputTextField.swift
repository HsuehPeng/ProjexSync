//
//  InputTextField.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/11.
//

import UIKit

class InputTextField: UITextField {
	private let padding: CGFloat = 16
	private let cornerRadius: CGFloat = 24
	
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
		layer.cornerRadius = cornerRadius
		backgroundColor = ColorConstants.secondary
	}
	
	override func textRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.insetBy(dx: padding, dy: 0)
	}
	
	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.insetBy(dx: padding, dy: 0)
	}
}

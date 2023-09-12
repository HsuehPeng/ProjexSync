//
//  BaseTextField.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/12.
//

import UIKit

class BaseTextField: UITextField {
	private let cornerRadius: CGFloat = 24
	
	var inputEdgeInset: UIEdgeInsets {
		return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
	}
	
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
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure() {
		layer.cornerRadius = cornerRadius
		backgroundColor = ColorConstants.secondary
	}
	
	override func textRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.inset(by: inputEdgeInset)
	}
	
	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.inset(by: inputEdgeInset)
	}
}

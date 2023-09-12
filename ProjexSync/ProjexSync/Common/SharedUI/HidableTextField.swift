//
//  HidableTextField.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/12.
//

import UIKit

class HidableTextField: BaseTextField {
	private lazy var hideButton: UIButton = {
		let view = UIButton()
		view.setImage(UIImage(systemName: "eye.slash")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .disabled)
		view.setImage(UIImage(systemName: "eye.slash.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
		view.setImage(UIImage(systemName: "eye.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .selected)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.addTarget(self, action: #selector(didTapHideButton), for: .touchUpInside)
		return view
	}()
	
	override func configure() {
		super.configure()
		
		reset()
		rightView = hideButton
		rightViewMode = .always
	}
	
	override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
		super.rightViewRect(forBounds: bounds)

		let x = bounds.maxX - 38
		let y = bounds.minY
		let width = 24.0
		let height = bounds.height

		return CGRect(x: x, y: y, width: width, height: height)
	}
	
	override var inputEdgeInset: UIEdgeInsets {
		return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 42)
	}
	
	@objc func didTapHideButton() {
		hideButton.isSelected.toggle()
		isSecureTextEntry.toggle()
	}
	
	override func becomeFirstResponder() -> Bool {
		hideButton.isEnabled = true
		return super.becomeFirstResponder()
	}
	
	override func resignFirstResponder() -> Bool {
		reset()
		return super.resignFirstResponder()
	}
	
	private func reset() {
		hideButton.isEnabled = false
		hideButton.isSelected = false
		isSecureTextEntry = true
	}

}

//
//  SearchTextField.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/18.
//

import UIKit

class SearchTextField: BaseTextField {
	lazy var searchImageView: UIImageView = {
		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.image = UIImage(systemName: "magnifyingglass")?.withTintColor(ColorConstants.grayscale70, renderingMode: .alwaysOriginal)
		view.contentMode = .center
		return view
	}()
	
	lazy var clearButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(systemName: "xmark"), for: .normal)
		button.addTarget(self, action: #selector(didTapClearButton), for: .touchUpInside)
		button.isHidden = true
		return button
	}()
	
	lazy var verticalLine: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = ColorConstants.grayscale20
		return view
	}()
	
	lazy var filterButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
		button.addTarget(self, action: #selector(didTapFilterButton), for: .touchUpInside)
		return button
	}()
	
	lazy var hStack: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.spacing = 8
		return stack
	}()
	
	override func configure() {
		super.configure()
		
		hStack.addArrangedSubview(clearButton)
		hStack.addArrangedSubview(verticalLine)
		hStack.addArrangedSubview(filterButton)

		leftView = searchImageView
		rightView = hStack
		rightViewMode = .always
	}
	
	override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
		super.leftViewRect(forBounds: bounds)
		
		let x = bounds.minX
		let y = bounds.minY
		let width = 34.0
		let height = bounds.height

		return CGRect(x: x, y: y, width: width, height: height)
	}
	
	override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
		super.rightViewRect(forBounds: bounds)

		let x = bounds.maxX - 71
		let y = bounds.minY
		let width = 55.0
		let height = bounds.height

		return CGRect(x: x, y: y, width: width, height: height)
	}
	
	override var inputEdgeInset: UIEdgeInsets {
		return UIEdgeInsets(top: 0, left: 42, bottom: 0, right: 79)
	}
	
	@objc func didTapClearButton() {
		text = nil
	}
	
	@objc func didTapFilterButton() {
		
	}
	
	override func setEmptyUI() {
		super.setEmptyUI()
		clearButton.isHidden = true
	}
	
	override func setFilledUI() {
		super.setFilledUI()
		clearButton.isHidden = false
	}
}

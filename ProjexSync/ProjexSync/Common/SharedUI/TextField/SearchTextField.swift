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
		view.contentMode = .scaleAspectFit
		return view
	}()
	
	lazy var clearButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(systemName: "xmark")?.withTintColor(ColorConstants.grayscale70, renderingMode: .alwaysOriginal), for: .normal)
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
		button.setImage(UIImage(systemName: "slider.horizontal.3")?.withTintColor(ColorConstants.grayscale70, renderingMode: .alwaysOriginal), for: .normal)
		button.addTarget(self, action: #selector(didTapFilterButton), for: .touchUpInside)
		return button
	}()
	
	lazy var hStack: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.spacing = 8
		stack.distribution = .fill
		return stack
	}()
	
	override func configure() {
		super.configure()
		
		hStack.addArrangedSubview(clearButton)
		hStack.addArrangedSubview(verticalLine)
		hStack.addArrangedSubview(filterButton)
		
		addSubview(searchImageView)
		addSubview(hStack)
		
		NSLayoutConstraint.activate([
			searchImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			searchImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
			searchImageView.widthAnchor.constraint(equalToConstant: 18),
			searchImageView.heightAnchor.constraint(equalToConstant: 18)
		])
		
		NSLayoutConstraint.activate([
			clearButton.widthAnchor.constraint(equalToConstant: 18),
			clearButton.heightAnchor.constraint(equalToConstant: 18)
		])
		
		NSLayoutConstraint.activate([
			verticalLine.widthAnchor.constraint(equalToConstant: 1)
		])
		
		NSLayoutConstraint.activate([
			filterButton.widthAnchor.constraint(equalToConstant: 18),
			filterButton.heightAnchor.constraint(equalToConstant: 18)
		])
		
		NSLayoutConstraint.activate([
			hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			hStack.centerYAnchor.constraint(equalTo: centerYAnchor),
		])
		
	}
	
	override var inputEdgeInset: UIEdgeInsets {
		return UIEdgeInsets(top: 0, left: 42, bottom: 0, right: 79)
	}
	
	@objc func didTapClearButton() {
		text = nil
		setEmptyUI()
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

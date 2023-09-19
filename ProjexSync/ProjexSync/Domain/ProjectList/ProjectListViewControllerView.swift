//
//  ProjectListViewControllerView.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/19.
//

import UIKit

final class ProjectListViewControllerView: ProgrammaticView {
	
	lazy var searchTextField: SearchTextField = {
		let textField = SearchTextField(placeHolder: "Search...")
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	
	override func configure() {
		backgroundColor = .red
	}
	
	override func setupConstraint() {
		addSubview(searchTextField)
		
		NSLayoutConstraint.activate([
			searchTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 28),
			searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
			searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
			searchTextField.heightAnchor.constraint(equalToConstant: 52)
		])
		
	}
}

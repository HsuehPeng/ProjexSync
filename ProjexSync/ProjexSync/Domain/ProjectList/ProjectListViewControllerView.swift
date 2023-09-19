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
	
	lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.refreshControl = refreshControl
		return tableView
	}()
	
	let refreshControl = UIRefreshControl()
	
	override func configure() {
		backgroundColor = .white
		
		searchTextField.delegate = self
	}
	
	override func setupConstraint() {
		addSubview(searchTextField)
		addSubview(tableView)
		
		NSLayoutConstraint.activate([
			searchTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 28),
			searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
			searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
			searchTextField.heightAnchor.constraint(equalToConstant: 52)
		])
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 24),
			tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
			tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
			tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
		])
		
	}
}

// MARK: - UITextFieldDelegate

extension ProjectListViewControllerView: UITextFieldDelegate {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		guard let textField = textField as? BaseTextField else { return true }
		let currentText = textField.text ?? ""
		let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
		
		updatedText.isEmpty ? textField.setEmptyUI() : textField.setFilledUI()
		
		return true
	}
}

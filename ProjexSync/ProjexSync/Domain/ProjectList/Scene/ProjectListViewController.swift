//
//  ProjectListViewController.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/18.
//

import UIKit

protocol ProjectListViewControllerDisplayLogic: AnyObject {
	func show(refresh: Bool)
	func show(projects: [Project])
	func show(errorMessage: String)
}

final class ProjectListViewController: UIViewController {
	// MARK: - Properties
	
	let contentView = ProjectListViewControllerView()
	let interactor: ProjectListViewControllerBusinessLogic
	
	var projects: [Project] = [] {
		didSet {
			contentView.tableView.reloadData()
		}
	}
	
	// MARK: - LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupContentView()
		didRefreshTableView()
	}
	
	init(interactor: ProjectListViewControllerBusinessLogic) {
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Action
	
	@objc func didRefreshTableView() {
		interactor.loadProjectList()
	}
	
	// MARK: - UI
	
	private func setupContentView() {
		view.addSubview(contentView)
		
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: view.topAnchor),
			contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
		contentView.refreshControl.addTarget(self, action: #selector(didRefreshTableView), for: .valueChanged)
		contentView.tableView.dataSource = self
	}
}

// MARK: - ProjectListViewControllerDisplayLogic

extension ProjectListViewController: ProjectListViewControllerDisplayLogic {
	func show(refresh: Bool) {
		refresh ? contentView.refreshControl.beginRefreshing() : contentView.refreshControl.endRefreshing()
	}
	
	func show(projects: [Project]) {
		self.projects = projects
	}
	
	func show(errorMessage: String) {
		
	}
}

// MARK: - UITableViewDataSource

extension ProjectListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return projects.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
}

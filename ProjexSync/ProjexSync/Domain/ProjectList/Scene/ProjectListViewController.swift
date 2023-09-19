//
//  ProjectListViewController.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/18.
//

import UIKit

protocol ProjectListViewControllerDisplayLogic: AnyObject {
	func showRefreshing()
}

final class ProjectListViewController: UIViewController {
	// MARK: - Properties
	
	let contentView = ProjectListViewControllerView()
	let interactor: ProjectListViewControllerBusinessLogic
	
	// MARK: - LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupContentView()
		contentView.refreshControl.addTarget(self, action: #selector(didRefreshTableView), for: .valueChanged)
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
	
	func showRefreshing(_ refreshing: Bool) {
		refreshing ? contentView.refreshControl.beginRefreshing() : contentView.refreshControl.endRefreshing()
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
	}
}

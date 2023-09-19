//
//  ProjectListViewController.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/18.
//

import UIKit

final class ProjectListViewController: UIViewController {
	// MARK: - Properties
	
	let contentView = ProjectListViewControllerView()
	let interactor: ProjectListViewControllerBussinessLogic
	
	// MARK: - LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupContentView()
		interactor.loadProjectList()
	}
	
	init(interactor: ProjectListViewControllerBussinessLogic) {
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
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

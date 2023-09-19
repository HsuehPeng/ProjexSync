//
//  ProjectListViewControllerFactory.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/18.
//

import UIKit

final class ProjectListViewControllerFactory {
	static func makeProjectListScene() -> ProjectListViewController {
		let presenter = ProjectListViewControllerPresenter()
		let projectListLoadingWorker = ProjectListLoadingWorker()
		let interactor = ProjectListViewControllerInteractor(presenter: presenter, projectListLoadingWorker: projectListLoadingWorker)
		let vc = ProjectListViewController(interactor: interactor)
		vc.title = "Project"
		return vc
	}
}

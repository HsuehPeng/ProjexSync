//
//  ProjectListViewControllerInteractor.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/19.
//

import Foundation

protocol ProjectListViewControllerBusinessLogic {
	func loadProjectList()
}

final class ProjectListViewControllerInteractor: ProjectListViewControllerBusinessLogic {
	let presenter: ProjectListViewControllerPresentationLogic
	let projectListLoadingWorker: ProjectListLoadingLogic
	
	func loadProjectList() {
		presenter.didStartLoadingProjectList()
		
		projectListLoadingWorker.load { [weak self] result in
			guard let self = self else { return }
			
			switch result {
			case .success(let projects):
				self.presenter.didFinishLoadingProjectList(with: projects)
			case .failure(let error):
				self.presenter.didFinishLoadingProjectList(with: error)
			}
		}
	}
	
	init(presenter: ProjectListViewControllerPresentationLogic, projectListLoadingWorker: ProjectListLoadingLogic) {
		self.presenter = presenter
		self.projectListLoadingWorker = projectListLoadingWorker
	}
}

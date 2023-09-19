//
//  ProjectListViewControllerInteractor.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/19.
//

import Foundation

protocol ProjectListViewControllerBussinessLogic {
	func loadProjectList()
}

final class ProjectListViewControllerInteractor: ProjectListViewControllerBussinessLogic {
	let projectListLoadingWorker: ProjectListLoadingLogic
	
	func loadProjectList() {
		
	}
	
	init(projectListLoadingWorker: ProjectListLoadingLogic) {
		self.projectListLoadingWorker = projectListLoadingWorker
	}
}

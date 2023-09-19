//
//  ProjectListViewControllerPresenter.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/19.
//

import Foundation

protocol ProjectListViewControllerPresentationLogic {
	func didStartLoadingProjectList()
	func didFinishLoadingProjectList(with project: [Project])
	func didFinishLoadingProjectList(with error: Error)
}

final class ProjectListViewControllerPresenter: ProjectListViewControllerPresentationLogic {
	func didStartLoadingProjectList() {
		
	}
	
	func didFinishLoadingProjectList(with project: [Project]) {
		
	}
	
	func didFinishLoadingProjectList(with error: Error) {
		
	}
	
}

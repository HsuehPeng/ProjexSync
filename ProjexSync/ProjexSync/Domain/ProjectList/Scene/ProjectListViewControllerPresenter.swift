//
//  ProjectListViewControllerPresenter.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/19.
//

import UIKit

protocol ProjectListViewControllerPresentationLogic {
	func didStartLoadingProjectList()
	func didFinishLoadingProjectList(with project: [Project])
	func didFinishLoadingProjectList(with error: Error)
}

final class ProjectListViewControllerPresenter: ProjectListViewControllerPresentationLogic {
	weak var controller: ProjectListViewControllerDisplayLogic?
	
	func didStartLoadingProjectList() {
		controller?.show(refresh: true)
	}
	
	func didFinishLoadingProjectList(with project: [Project]) {
		
	}
	
	func didFinishLoadingProjectList(with error: Error) {
		
	}
	
}

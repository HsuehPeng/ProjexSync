//
//  ProjectListViewControllerInteractorTests.swift
//  ProjexSyncTests
//
//  Created by Hsueh Peng Tseng on 2023/9/19.
//

import XCTest
@testable import ProjexSync

final class ProjectListViewControllerInteractorTests: XCTestCase {
	
	

	// MARK: - Helpers
	
	private func makeSut() -> (ProjectListViewControllerInteractor, ProjectListLoadingWorkerSpy) {
		let projectListLoadingWorkerSpy = ProjectListLoadingWorkerSpy()
		let sut = ProjectListViewControllerInteractor(projectListLoadingWorker: projectListLoadingWorkerSpy)
		return (sut, projectListLoadingWorkerSpy)
	}
	
	class ProjectListLoadingWorkerSpy: ProjectListLoadingLogic{
		
	}
}

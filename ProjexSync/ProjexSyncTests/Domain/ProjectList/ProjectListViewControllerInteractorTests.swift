//
//  ProjectListViewControllerInteractorTests.swift
//  ProjexSyncTests
//
//  Created by Hsueh Peng Tseng on 2023/9/19.
//

import XCTest
@testable import ProjexSync

final class ProjectListViewControllerInteractorTests: XCTestCase {
	
	func test_loadProjectList_projectListLoadingWorkerDidCallLoad() {
		let (sut, projectListLoadingWorker) = makeSut()
		let expectedResult: [ProjectListLoadingWorkerSpy.Message] = [.load]
		
		sut.loadProjectList()
		
		XCTAssertEqual(projectListLoadingWorker.messages, expectedResult)
	}

	// MARK: - Helpers
	
	private func makeSut() -> (ProjectListViewControllerInteractor, ProjectListLoadingWorkerSpy) {
		let projectListLoadingWorkerSpy = ProjectListLoadingWorkerSpy()
		let sut = ProjectListViewControllerInteractor(projectListLoadingWorker: projectListLoadingWorkerSpy)
		return (sut, projectListLoadingWorkerSpy)
	}
	
	class ProjectListLoadingWorkerSpy: ProjectListLoadingLogic {
		enum Message {
			case load
		}
		
		var messages = [Message]()
		
		func load(completion: @escaping (LoadResult) -> Void) {
			messages.append(.load)
		}
	}
}

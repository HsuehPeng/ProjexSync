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
		let (sut, projectListLoadingWorker, _) = makeSut()
		let expectedResult: [ProjectListLoadingWorkerSpy.Message] = [.load]
		
		sut.loadProjectList()
		
		XCTAssertEqual(projectListLoadingWorker.messages, expectedResult)
	}
	
	func test_loadProjectList_presenterDidStartLoadingProjectList() {
		let (sut, _, presenter) = makeSut()
		let expectedResult: [ProjectListViewControllerPresenterSpy.Message] = [.didStartLoadingProjectList]
		
		sut.loadProjectList()
		
		XCTAssertEqual(presenter.messages, expectedResult)
	}
	
	func test_loadProjectList_presenterDidFinishLoadingProjectList_whenSucceedToLoadProjectList() {
		let (sut, projectListLoadingWorker, presenter) = makeSut()
		let expectedResult: [ProjectListViewControllerPresenterSpy.Message] = [.didStartLoadingProjectList, .didFinishLoadingProjectListWithProjects]
		
		sut.loadProjectList()
		projectListLoadingWorker.completeLoadProjectList(with: .success([]))
		
		XCTAssertEqual(presenter.messages, expectedResult)
	}
	
	func test_loadProjectList_presenterDidFinishLoadingProjectList_whenFailToLoadProjectList() {
		let (sut, projectListLoadingWorker, presenter) = makeSut()
		let expectedResult: [ProjectListViewControllerPresenterSpy.Message] = [.didStartLoadingProjectList, .didFinishLoadingProjectListWithError]
		
		sut.loadProjectList()
		projectListLoadingWorker.completeLoadProjectList(with: .failure(anyError()))
		
		XCTAssertEqual(presenter.messages, expectedResult)
	}

	// MARK: - Helpers
	
	private func makeSut() -> (ProjectListViewControllerInteractor, ProjectListLoadingWorkerSpy, ProjectListViewControllerPresenterSpy) {
		let presenterSpy = ProjectListViewControllerPresenterSpy()
		let projectListLoadingWorkerSpy = ProjectListLoadingWorkerSpy()
		let sut = ProjectListViewControllerInteractor(presenter: presenterSpy, projectListLoadingWorker: projectListLoadingWorkerSpy)
		return (sut, projectListLoadingWorkerSpy, presenterSpy)
	}
	
	class ProjectListLoadingWorkerSpy: ProjectListLoadingLogic {
		enum Message {
			case load
		}
		
		var messages = [Message]()
		var completions = [(LoadResult) -> Void]()
		
		func completeLoadProjectList(with result: LoadResult, at index: Int = 0) {
			completions[index](result)
		}
		
		func load(completion: @escaping (LoadResult) -> Void) {
			completions.append(completion)
			messages.append(.load)
		}
	}
	
	class ProjectListViewControllerPresenterSpy: ProjectListViewControllerPresentationLogic {
		enum Message {
			case didStartLoadingProjectList
			case didFinishLoadingProjectListWithProjects
			case didFinishLoadingProjectListWithError
		}
		
		var messages = [Message]()
		
		func didStartLoadingProjectList() {
			messages.append(.didStartLoadingProjectList)
		}

		func didFinishLoadingProjectList(with project: [ProjexSync.Project]) {
			messages.append(.didFinishLoadingProjectListWithProjects)
		}
		
		func didFinishLoadingProjectList(with error: Error) {
			messages.append(.didFinishLoadingProjectListWithError)
		}
	}
}

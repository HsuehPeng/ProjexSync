//
//  ProjectListViewControllerTests.swift
//  ProjexSyncTests
//
//  Created by Hsueh Peng Tseng on 2023/9/18.
//

import XCTest
@testable import ProjexSync

final class ProjectListViewControllerTests: XCTestCase {
	
	func test_viewDidLoad_loadProject_interactorCallLoadProject() {
		let (sut, interactor) = makeSut()
		let expectedResult = [ProjectListBussinessLogicSpy.Message.loadProjectList]

		sut.loadViewIfNeeded()
		
		XCTAssertEqual(interactor.messages, expectedResult)
	}
	
	func test_tableView_refresh_interactorCallLoadProject() {
		let (sut, interactor) = makeSut()
		let expectedResult: [ProjectListBussinessLogicSpy.Message] = [.loadProjectList, .loadProjectList]

		sut.loadViewIfNeeded()
		sut.refreshProjectList()

		XCTAssertEqual(interactor.messages, expectedResult)
	}
	
	// MARK: - Helpers
	
	private func makeSut() -> (ProjectListViewController, ProjectListBussinessLogicSpy) {
		let interactorSpy = ProjectListBussinessLogicSpy()
		let sut = ProjectListViewController(interactor: interactorSpy)

		return (sut, interactorSpy)
	}
	
	class ProjectListBussinessLogicSpy: ProjectListViewControllerBusinessLogic {
		enum Message {
			case loadProjectList
		}
		
		var messages: [Message] = []
		
		func loadProjectList() {
			messages.append(.loadProjectList)
		}
	}
}

private extension ProjectListViewController {
	func refreshProjectList() {
		contentView.refreshControl.simulatePullToRefresh()
	}
}

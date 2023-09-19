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
		
		sut.loadViewIfNeeded()
		let expectedResult = [ProjectListBussinessLogicSpy.Message.loadProjectList]

		XCTAssertEqual(interactor.messages, expectedResult)
	}
	
	// MARK: - Helpers
	
	private func makeSut() -> (ProjectListViewController, ProjectListBussinessLogicSpy) {
		let interactorSpy = ProjectListBussinessLogicSpy()
		let sut = ProjectListViewController(interactor: interactorSpy)
		
		return (sut, interactorSpy)
	}
	
	class ProjectListBussinessLogicSpy: ProjectListViewControllerBussinessLogic {
		enum Message {
			case loadProjectList
		}
		
		var messages: [Message] = []
		
		func loadProjectList() {
			messages.append(.loadProjectList)
		}
	}
}

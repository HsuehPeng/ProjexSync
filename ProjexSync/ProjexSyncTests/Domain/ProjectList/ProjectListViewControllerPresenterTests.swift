//
//  ProjectListViewControllerPresenterTests.swift
//  ProjexSyncTests
//
//  Created by Hsueh Peng Tseng on 2023/9/19.
//

import XCTest
@testable import ProjexSync

final class ProjectListViewControllerPresenterTests: XCTestCase {
	
	func test_didStartLoadingProjectList_controllerCallsShowRefreshing() {
		let (sut, controller) = makeSut()
		let expectedResult: [ProjectListViewControllerSpy.Message] = [.showRefresh(true)]
		
		sut.didStartLoadingProjectList()
		
		XCTAssertEqual(controller.messages, expectedResult)
	}

	// MARK: - Helpers
	
	private func makeSut() -> (ProjectListViewControllerPresenter, ProjectListViewControllerSpy) {
		let sut = ProjectListViewControllerPresenter()
		let viewController = ProjectListViewControllerSpy()
		sut.controller = viewController
		return (sut, viewController)
	}
	
	class ProjectListViewControllerSpy: ProjectListViewControllerDisplayLogic {
		enum Message: Equatable {
			case showRefresh(Bool)
		}
		
		var messages = [Message]()
		
		func show(refresh: Bool) {
			messages.append(.showRefresh(refresh))
		}
	}
}

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
		
		sut.didStartLoadingProjectList()
		
		XCTAssertTrue(controller.showRefreshingCalled)
	}

	// MARK: - Helpers
	
	private func makeSut() -> (ProjectListViewControllerPresenter, ProjectListViewControllerMock) {
		let sut = ProjectListViewControllerPresenter()
		let viewController = ProjectListViewControllerMock()
		sut.controller = viewController
		return (sut, viewController)
	}
	
	class ProjectListViewControllerMock: ProjectListViewControllerDisplayLogic {
		func show(refresh: Bool) {
			showRefreshingCalled = true
		}
		
		var showRefreshingCalled = false

	}
}

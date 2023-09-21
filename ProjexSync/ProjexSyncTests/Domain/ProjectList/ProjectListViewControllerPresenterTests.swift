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

	func test_didFinishLoadingProjectListWithProjects_controllerShowRefreshToFalse_whenControllerStartLoadingProjectListAndFinishLoadingProjectList() {
		let (sut, controller) = makeSut()
		let projectList = [Project]()
		let expectedResult: [ProjectListViewControllerSpy.Message] = [.showRefresh(true), .showRefresh(false), .showProjects(projectList)]
		
		sut.didStartLoadingProjectList()
		sut.didFinishLoadingProjectList(with: projectList)
		
		XCTAssertEqual(controller.messages, expectedResult)
	}
	
	func test_didFinishLoadingProjectListWithProjects_controllerShowProjectListWhenFinishLoadingProjectList() {
		let (sut, controller) = makeSut()
		let projectList = [Project]()
		let expectedResult: [ProjectListViewControllerSpy.Message] = [.showRefresh(false), .showProjects(projectList)]
		
		sut.didFinishLoadingProjectList(with: projectList)
		
		XCTAssertEqual(controller.messages, expectedResult)
	}
	
	func test_didFinishLoadingProjectListWithError_controllerShowRefreshToFalseAndShowError() {
		let (sut, controller) = makeSut()
		let expectedResult: [ProjectListViewControllerSpy.Message] = [.showRefresh(false), .showError]
		
		sut.didFinishLoadingProjectList(with: anyError())
		
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
			case showProjects([Project])
			case showError
		}
		
		var messages = [Message]()
		
		func show(refresh: Bool) {
			messages.append(.showRefresh(refresh))
		}
		
		func show(projects: [ProjexSync.Project]) {
			messages.append(.showProjects(projects))
		}
		
		func show(error: Error) {
			messages.append(.showError)
		}
	}
}

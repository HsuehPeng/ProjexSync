//
//  ProjectListViewControllerTests.swift
//  ProjexSyncTests
//
//  Created by Hsueh Peng Tseng on 2023/9/18.
//

import XCTest
@testable import ProjexSync

final class ProjectListUseCaseIntegrationTests: XCTestCase {
	
	func test_viewDidLoad_loadProject_interactorCallLoadProject() {
		let (sut, interactor, _) = makeSut()
		let expectedResult = [ProjectListInteractorSpy.Message.loadProjectList]

		sut.loadViewIfNeeded()
		
		XCTAssertEqual(interactor.messages, expectedResult)
	}
	
	func test_tableView_refresh_interactorCallLoadProject() {
		let (sut, interactor, _) = makeSut()
		let expectedResult: [ProjectListInteractorSpy.Message] = [.loadProjectList, .loadProjectList]

		sut.loadViewIfNeeded()
		sut.refreshProjectList()

		XCTAssertEqual(interactor.messages, expectedResult)
	}
	
	func test_showProjects_projectsGetFromPresenter() {
		let (sut, _, presenter) = makeSut()
		let projects = [anyProject]

		presenter.didFinishLoadingProjectList(with: projects)

		XCTAssertEqual(sut.projects, projects)
	}
	
	func test_showProjects_tableView_numbersOfCell() {
		let (sut, _, presenter) = makeSut()
		let projects = [anyProject]
		
		sut.loadViewIfNeeded()
		presenter.didFinishLoadingProjectList(with: projects)

		XCTAssertEqual(sut.numbersOfCell(), projects.count)
	}
	
	// MARK: - Helpers
	
	private func makeSut() -> (ProjectListViewController, ProjectListInteractorSpy, ProjectListViewControllerPresenter) {
		let presenter = ProjectListViewControllerPresenter()
		let interactorSpy = ProjectListInteractorSpy()
		let sut = ProjectListViewController(interactor: interactorSpy)
		
		presenter.controller = sut
		
		return (sut, interactorSpy, presenter)
	}
	
	var anyProject: Project {
		return Project(id: "id",
					   name: "name",
					   creationDate: Date(timeIntervalSince1970: 0),
					   deadline: Date(timeIntervalSince1970: 10),
					   overview: "overview",
					   participants: [:],
					   priority: .high,
					   progress: 0)
	}
	
	class ProjectListInteractorSpy: ProjectListViewControllerBusinessLogic {
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
	
	func numbersOfCell(in section: Int = 0) -> Int {
		contentView.tableView.dataSource?.tableView(contentView.tableView, numberOfRowsInSection: section) ?? 0
	}
}

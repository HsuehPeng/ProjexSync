//
//  ProjectListLoadingWorkerTests.swift
//  ProjexSyncTests
//
//  Created by Hsueh Peng Tseng on 2023/9/21.
//

import XCTest
@testable import ProjexSync

final class ProjectListLoadingWorkerTests: XCTestCase {
	
	func test_load_projectListLoaderDidCallLoad() {
		let (sut, loader) = makeSut()
		
		sut.load { _ in }
		
		XCTAssertTrue(loader.didCallLoad)
	}
	
	func test_load_completeWithNetworkErrorWhenLoaderFailToLoadData() {
		let (sut, loader) = makeSut()
		let anyError = anyError()
		let expetectedError = ProjectListLoadingWorker.Error.network
		
		expect(sut, completeWithResult: .failure(expetectedError), when: {
			loader.completeLoadWith(.failure(anyError))
		})
	}
	
	func test_load_completeWithDecodeErrorWhenLoaderSucceedToLoadDataButFailToDecodeData() {
		let (sut, loader) = makeSut()
		let invalidData = invalidData()
		let expetectedError = ProjectListLoadingWorker.Error.decode
		
		expect(sut, completeWithResult: .failure(expetectedError), when: {
			loader.completeLoadWith(.success(invalidData))
		})
	}
	
	func test_load_completeWithSuccessWhenLoaderSucceedToLoadValidData() {
		let (sut, loader) = makeSut()
		let validData = validData(from: projects)
		let expectedProjects = projects
		
		expect(sut, completeWithResult: .success(expectedProjects), when: {
			loader.completeLoadWith(.success(validData))
		})
	}
	
	// MARK: - Helpers
	
	private func makeSut() -> (ProjectListLoadingWorker, ProjectListLoaderSpy) {
		let projectListLoader = ProjectListLoaderSpy()
		let sut = ProjectListLoadingWorker(loader: projectListLoader)
		return (sut, projectListLoader)
	}
	
	private func expect(_ sut: ProjectListLoadingWorker, completeWithResult expectedResult: ProjectListLoadingLogic.LoadResult, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
		let exp = expectation(description: "Load complete")
		
		sut.load { retrievedResult in
			switch (retrievedResult, expectedResult) {
			case let (.failure(retrievedError as ProjectListLoadingWorker.Error), .failure(expectedError as ProjectListLoadingWorker.Error)):
				XCTAssertEqual(retrievedError, expectedError, file: file, line: line)
				XCTAssertEqual(retrievedError.localizedDescription, expectedError.localizedDescription, file: file, line: line)

			case let (.success(retrievedProjects), .success(expectedProjects)):
				XCTAssertEqual(retrievedProjects, expectedProjects, file: file, line: line)
			default:
				XCTFail("Expected result \(expectedResult), got \(retrievedResult) instead", file: file, line: line)
			}
			exp.fulfill()
		}
		
		action()
		
		wait(for: [exp], timeout: 1.0)
	}
	
	private var projects: [Project] {
		return [Project(id: "id", name: "name")]
	}
	
	private func invalidData() -> Data {
		return Data("invalid".utf8)
	}
	
	private func validData(from projects: [Project]) -> Data {
		return try! JSONEncoder().encode(projects)
	}
	
	class ProjectListLoaderSpy: FirebaseDataLoader {
		var didCallLoad = false
		var completions = [(LoadResult) -> Void]()
		
		func load(completion: @escaping (LoadResult) -> Void) {
			didCallLoad = true
			completions.append(completion)
		}
		
		func completeLoadWith(_ result: LoadResult, at index: Int = 0) {
			completions[index](result)
		}
	}

}

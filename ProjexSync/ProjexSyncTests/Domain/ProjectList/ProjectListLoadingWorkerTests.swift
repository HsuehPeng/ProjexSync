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
	
	func test_load_completeWithErrorWhenLoaderFailToLoadData() {
		let (sut, loader) = makeSut()
		let anyError = anyError()
		let expetectedResult = ProjectListLoadingWorker.Error.network
		let exp = expectation(description: "Load complete")
		
		sut.load { retrievedResult in
			switch retrievedResult {
			case .failure(let retrievedError):
				XCTAssertEqual(retrievedError as? ProjectListLoadingWorker.Error, expetectedResult)
			default:
				XCTFail("Expected to fail, got success instead")
			}
			exp.fulfill()
		}
		
		loader.completeLoadWith(.failure(anyError))
		
		wait(for: [exp], timeout: 1.0)
	}
	
	// MARK: - Helpers
	
	private func makeSut() -> (ProjectListLoadingWorker, ProjectListLoaderMock) {
		let projectListLoader = ProjectListLoaderMock()
		let sut = ProjectListLoadingWorker(loader: projectListLoader)
		return (sut, projectListLoader)
	}
	
	class ProjectListLoaderMock: FirebaseDataLoader {
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

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
		
		expect(sut, completeWithError: .network, when: {
			loader.completeLoadWith(.failure(anyError))
		})
	}
	
	func test_load_completeWithDecodeErrorWhenLoaderSucceedToLoadDataButFailToDecodeData() {
		let (sut, loader) = makeSut()
		let invalidData = invalidData()
		let expetectedError = ProjectListLoadingWorker.Error.decode
		
		expect(sut, completeWithError: .decode, when: {
			loader.completeLoadWith(.success(invalidData))
		})
	}
	
	// MARK: - Helpers
	
	private func makeSut() -> (ProjectListLoadingWorker, ProjectListLoaderMock) {
		let projectListLoader = ProjectListLoaderMock()
		let sut = ProjectListLoadingWorker(loader: projectListLoader)
		return (sut, projectListLoader)
	}
	
	private func expect(_ sut: ProjectListLoadingWorker, completeWithError expectedError: ProjectListLoadingWorker.Error, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
		let exp = expectation(description: "Load complete")
		
		sut.load { retrievedResult in
			switch retrievedResult {
			case .failure(let retrievedError):
				XCTAssertEqual(retrievedError as? ProjectListLoadingWorker.Error, expectedError, file: file, line: line)
			default:
				XCTFail("Expected to fail with \(expectedError), got success instead", file: file, line: line)
			}
			exp.fulfill()
		}
		
		action()
		
		wait(for: [exp], timeout: 1.0)
	}
	
	private func invalidData() -> Data {
		return Data("invalid".utf8)
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

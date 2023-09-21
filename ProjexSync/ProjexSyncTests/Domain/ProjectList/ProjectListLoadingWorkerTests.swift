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
		let exp = expectation(description: "Load complete")
		
		sut.load { retrievedResult in
			switch retrievedResult {
			case .failure(let retrievedError):
				XCTAssertEqual(retrievedError as? ProjectListLoadingWorker.Error, expetectedError)
			default:
				XCTFail("Expected to fail, got success instead")
			}
			exp.fulfill()
		}
		
		loader.completeLoadWith(.failure(anyError))
		
		wait(for: [exp], timeout: 1.0)
	}
	
	func test_load_completeWithDecodeErrorWhenLoaderSucceedToLoadDataButFailToDecodeData() {
		let (sut, loader) = makeSut()
		let invalidData = invalidData()
		let expetectedError = ProjectListLoadingWorker.Error.decode
		let exp = expectation(description: "Load complete")
		
		sut.load { retrievedResult in
			switch retrievedResult {
			case .failure(let retrievedError):
				XCTAssertEqual(retrievedError as? ProjectListLoadingWorker.Error, expetectedError)
			default:
				XCTFail("Expected to fail, got success instead")
			}
			exp.fulfill()
		}
		
		loader.completeLoadWith(.success(invalidData))
		
		wait(for: [exp], timeout: 1.0)
	}
	
	// MARK: - Helpers
	
	private func makeSut() -> (ProjectListLoadingWorker, ProjectListLoaderMock) {
		let projectListLoader = ProjectListLoaderMock()
		let sut = ProjectListLoadingWorker(loader: projectListLoader)
		return (sut, projectListLoader)
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

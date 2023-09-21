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
	
	// MARK: - Helpers
	
	private func makeSut() -> (ProjectListLoadingWorker, ProjectListLoaderMock) {
		let projectListLoader = ProjectListLoaderMock()
		let sut = ProjectListLoadingWorker(loader: projectListLoader)
		return (sut, projectListLoader)
	}
	
	class ProjectListLoaderMock: FirebaseDataLoader {
		var didCallLoad = false
		
		func load(completion: @escaping (LoadResult) -> Void) {
			didCallLoad = true
		}
	}

}

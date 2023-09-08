//
//  XCTestCase+MemoryLeakTracking.swift
//  ProjexSyncTests
//
//  Created by Hsueh Peng Tseng on 2023/9/7.
//

import XCTest

extension XCTestCase {
	func trackForMemoryleaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
		addTeardownBlock { [weak instance] in
			XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
		}
	}
}

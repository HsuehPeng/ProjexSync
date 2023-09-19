//
//  ProjectListLoadingWorker.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/19.
//

import Foundation

protocol ProjectListLoadingLogic {
	typealias LoadResult = Result<[Project], Error>
	func load(completion: @escaping (LoadResult) -> Void)
}

final class ProjectListLoadingWorker: ProjectListLoadingLogic {
	func load(completion: @escaping (LoadResult) -> Void) {
		
	}
}

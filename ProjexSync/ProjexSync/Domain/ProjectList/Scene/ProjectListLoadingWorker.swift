//
//  ProjectListLoadingWorker.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/19.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift

protocol FirebaseDataLoader {
	typealias LoadResult = Result<Data, Error>
	func load(completion: @escaping (LoadResult) -> Void)
}

final class FirebaseProjectListDataLoader: FirebaseDataLoader {
	func load(completion: @escaping (LoadResult) -> Void) {
		
	}
}

protocol ProjectListLoadingLogic {
	typealias LoadResult = Result<[Project], Error>
	func load(completion: @escaping (LoadResult) -> Void)
}

final class ProjectListLoadingWorker: ProjectListLoadingLogic {
	let loader: FirebaseDataLoader
	
	func load(completion: @escaping (LoadResult) -> Void) {
		loader.load { result in
			
		}
	}
	
	init(loader: FirebaseDataLoader) {
		self.loader = loader
	}
}

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
	private let loader: FirebaseDataLoader
	
	enum Error: Swift.Error, LocalizedError {
		case network
		
		var errorDescription: String? {
			switch self {
			case .network:
				return "Network error"
			}
		}
	}
	
	func load(completion: @escaping (LoadResult) -> Void) {
		loader.load { result in
			switch result {
			case .failure:
				completion(.failure(Error.network))
			default:
				break
			}
		}
	}
	
	init(loader: FirebaseDataLoader) {
		self.loader = loader
	}
}

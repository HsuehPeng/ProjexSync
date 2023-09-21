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
	let ref = Firestore.firestore().collection("User").document("OFohDxvHlahAOB4YVQc6AKuyG4e2").collection("Project")
	
	func load(completion: @escaping (LoadResult) -> Void) {
		ref.getDocuments { snapshot, error in
			if let error = error {
				completion(.failure(error))
			} else {
				do {
					let dict = snapshot?.documents.map{ $0.data() } ?? []
					let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
					completion(.success(jsonData))
					
				} catch(let decodeError) {
					completion(.failure(decodeError))
				}
			}
		}
	}
}

protocol ProjectListLoadingLogic {
	typealias LoadResult = Result<[Project], Error>
	func load(completion: @escaping (LoadResult) -> Void)
}

final class ProjectListLoadingWorker {
	private let loader: FirebaseDataLoader
	
	enum Error: Swift.Error, LocalizedError {
		case network
		case decode
		
		var errorDescription: String? {
			switch self {
			case .network:
				return "Network error"
			case .decode:
				return "Failed to decode data"
			}
		}
	}
	
	init(loader: FirebaseDataLoader) {
		self.loader = loader
	}
}

extension ProjectListLoadingWorker: ProjectListLoadingLogic {
	func load(completion: @escaping (LoadResult) -> Void) {
		loader.load { result in
			switch result {
			case .failure:
				completion(.failure(Error.network))
			case .success(let data):
				do {
					let decoder = JSONDecoder()
					let projects = try decoder.decode([Project].self, from: data)
					completion(.success(projects))
					
				} catch {
					completion(.failure(Error.decode))
				}
			}
		}
	}
}

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

protocol ProjectListLoadingLogic {
	typealias LoadResult = Result<[Project], Error>
	func load(completion: @escaping (LoadResult) -> Void)
}

final class ProjectListLoadingWorker: ProjectListLoadingLogic {
	func load(completion: @escaping (LoadResult) -> Void) {
		let ref = Firestore.firestore().collection("User").document("OFohDxvHlahAOB4YVQc6AKuyG4e2").collection("Project")
		ref.getDocuments { snapshot, error in
			if let error = error {
				completion(.failure(error))
			} else {
				var projects = [Project]()
				for document in snapshot!.documents {
					let data = document.data()
					
					let project = Project(name: data["name"] as! String)
					projects.append(project)
				}
				
				completion(.success(projects))
			}
		}
	}
}

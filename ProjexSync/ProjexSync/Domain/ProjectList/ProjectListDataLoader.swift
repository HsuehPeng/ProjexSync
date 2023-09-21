//
//  ProjectListDataLoader.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/21.
//

import FirebaseFirestore

final class ProjectListDataLoader: FirebaseDataLoader {
	let ref = Firestore.firestore().collection("Project")
	
	func load(completion: @escaping (LoadResult) -> Void) {
		
		ref.whereField("participants.OFohDxvHlahAOB4YVQc6AKuyG4e2", isNotEqualTo: "").getDocuments { snapshot, error in
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

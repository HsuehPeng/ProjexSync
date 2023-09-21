//
//  Project.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/19.
//

import Foundation

struct Project: Codable, Equatable {
	enum Role: String, Codable {
		case editor
		case member
	}
	
	enum Priority: String, Codable {
		case high
		case medium
		case low
	}
	
	let id: String
	let name: String
	let creationDate: Date
	let deadline: Date
	let overview: String
	let participants: [String: Role]
	let priority: Priority
	let progress: Int
}

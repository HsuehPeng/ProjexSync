//
//  FirebaseDataLoader.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/21.
//

import Foundation

protocol FirebaseDataLoader {
	typealias LoadResult = Result<Data, Error>
	func load(completion: @escaping (LoadResult) -> Void)
}

//
//  ProjectListViewController.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/18.
//

import UIKit

final class ProjectListViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let textField = SearchTextField(placeHolder: "Asdf")
		view.backgroundColor = .white
		view.addSubview(textField)
		textField.frame = CGRect(origin: CGPoint(x: 16, y: view.center.y), size: CGSize(width: view.frame.width - 32, height: 52))
	}
}

//
//  HomeViewController.swift
//  InList
//
//  Created by Idris on 14/04/25.
//

import UIKit

class HomeViewController: UIViewController {

	// MARK: - Outlets
	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.delegate = self
			tableView.dataSource = self
			tableView.registerNIB(with: InsuranceCell.self)
		}
	}
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		title = "Daftar Asuransi"
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueCell(with: InsuranceCell.self) {
			return cell
		}
		
		return UITableViewCell()
	}
}

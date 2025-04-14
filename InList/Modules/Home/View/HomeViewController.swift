//
//  HomeViewController.swift
//  InList
//
//  Created by Idris on 14/04/25.
//

import UIKit

class HomeViewController: UIViewController {
	
	// MARK: - Properties
	let viewModel: HomeViewModel = HomeViewModel()

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
		setupViewModel()
    }
	
	private func setupViewModel() {
		viewModel.getInsuranceList()
		viewModel.didGetInsurance = { [weak self] in
			self?.tableView.reloadData()
		}
	}
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numOfRows()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let insuranceAt = viewModel.selectItemAt(index: indexPath.row)
		if let cell = tableView.dequeueCell(with: InsuranceCell.self) {
			cell.setupCell(insurance: insuranceAt)
			return cell
		}
		
		return UITableViewCell()
	}
}

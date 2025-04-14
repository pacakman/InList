//
//  HomeViewController.swift
//  InList
//
//  Created by Idris on 14/04/25.
//

import UIKit
import SkeletonView

class HomeViewController: UIViewController {
	
	// MARK: - Properties
	let viewModel: HomeViewModel = HomeViewModel()

	// MARK: - Outlets
	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.delegate = self
			tableView.dataSource = self
			tableView.registerNIB(with: InsuranceCell.self)
			tableView.estimatedRowHeight = 90
			tableView.showsVerticalScrollIndicator = false
		}
	}
	
	@IBOutlet private weak var searchBar: UISearchBar! {
		didSet {
			searchBar.delegate = self
		}
	}
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		title = "Daftar Asuransi"
		setupViewModel()
    }
	
	private func setupViewModel() {
		viewModel.updateLoadingStatus = { [weak self] isLoading in
			if isLoading {
				self?.tableView.showAnimatedGradientSkeleton()
			}
			else {
				self?.tableView.stopSkeletonAnimation()
				self?.tableView.hideSkeleton()
			}
		}
		viewModel.getInsuranceList()
		viewModel.didGetInsurance = { [weak self] in
			self?.tableView.reloadData()
		}
		
	}
}

extension HomeViewController: SkeletonTableViewDataSource, UITableViewDelegate {
	
	func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
		return String(describing: InsuranceCell.self)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numOfRows()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let insuranceAt = viewModel.selectItemAt(index: indexPath.row)
		if let cell = tableView.dequeueCell(with: InsuranceCell.self) {
			if viewModel.numOfRows() == 1 && !viewModel.keyword.isEmpty {
				cell.setupEmptyResult(insurance: insuranceAt)
				cell.selectionStyle = .none
			}
			else {
				cell.setupCell(insurance: insuranceAt)
				cell.selectionStyle = .none
			}
			return cell
		}
		
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if viewModel.isInsuranceFound(index: indexPath.row){
			let vc = InsuranceDetailViewController()
			vc.insurance = viewModel.selectItemAt(index: indexPath.row)
			navigationController?.pushViewController(vc, animated: true)
		}
	}
}

extension HomeViewController: UISearchBarDelegate {
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		searchBar.showsCancelButton = true
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		viewModel.keyword = ""
		searchBar.text = ""
		viewModel.getInsuranceList { [weak self] in
			self?.searchBar.endEditing(true)
			self?.searchBar.showsCancelButton = false
		}
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		viewModel.keyword = searchBar.text ?? ""
		viewModel.filterInsuranceCell { [weak self] in
			self?.searchBar.endEditing(true)
			self?.searchBar.showsCancelButton = false
			self?.tableView.reloadData()
		}
	}
}

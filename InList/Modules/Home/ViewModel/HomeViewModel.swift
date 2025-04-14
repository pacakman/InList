//
//  HomeViewModel.swift
//  InList
//
//  Created by Idris on 14/04/25.
//

class HomeViewModel {
	
	private let service: HomeServiceProtocol
	private var insuranceListCell: [InsuranceCellModel] = [] {
		willSet {
			filteredInsuranceListCell = newValue
		}
	}
	private var filteredInsuranceListCell: [InsuranceCellModel] = []
	
	var updateLoadingStatus: ((Bool) -> Void)?
	var didGetInsurance: (() -> Void)?
	var showErrorMessage: ((String) -> Void)?
	var keyword: String = ""
	var isSearchActive: Bool = false
	
	init(withService service: HomeServiceProtocol = HomeService() ) {
		self.service = service
	}
	
	func numOfRows() -> Int {
		return filteredInsuranceListCell.count > 0 ? filteredInsuranceListCell.count : 1
	}
	
	func selectItemAt(index: Int) -> InsuranceCellModel {
		return filteredInsuranceListCell.count > 0 ? filteredInsuranceListCell[index] : InsuranceCellModel(title: "", body: "Asuransi tidak ditemukan")
	}
	
	func getInsuranceList(completion: (() -> Void)? = nil) {
		self.updateLoadingStatus?(true)
		service.getInsuranceList { [weak self] result in
			self?.updateLoadingStatus?(false)
			self?.insuranceListCell = result.map({InsuranceCellModel(title: $0.title, body: $0.body)})
			self?.didGetInsurance?()
			completion?()
		} onFailure: { [weak self] error in
			self?.updateLoadingStatus?(false)
			completion?()
		}
	}
	
	func filterInsuranceCell(completion: (() -> Void)?) {
		if keyword.isEmpty {
			filteredInsuranceListCell = insuranceListCell
		}
		else {
			filteredInsuranceListCell = insuranceListCell.filter({ insurance in
				return insurance.title.lowercased().contains(keyword.lowercased())
			})
		}
		completion?()
	}
}

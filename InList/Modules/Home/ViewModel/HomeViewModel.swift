//
//  HomeViewModel.swift
//  InList
//
//  Created by Idris on 14/04/25.
//

class HomeViewModel {
	
	private let service: HomeServiceProtocol
	private var insuranceListCell: [InsuranceCellModel] = []
	
	var updateLoadingStatus: ((Bool) -> Void)?
	var didGetInsurance: (() -> Void)?
	var showErrorMessage: ((String) -> Void)?
	
	init(withService service: HomeServiceProtocol = HomeService() ) {
		self.service = service
	}
	
	func numOfRows() -> Int {
		return insuranceListCell.count
	}
	
	func selectItemAt(index: Int) -> InsuranceCellModel {
		return insuranceListCell[index]
	}
	
	func getInsuranceList() {
		self.updateLoadingStatus?(true)
		service.getInsuranceList { [weak self] result in
			self?.updateLoadingStatus?(false)
			self?.insuranceListCell = result.map({InsuranceCellModel(title: $0.title, body: $0.body)})
			self?.didGetInsurance?()
		} onFailure: { [weak self] error in
			self?.updateLoadingStatus?(false)
		}
	}
}

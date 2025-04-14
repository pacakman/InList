//
//  HomeService.swift
//  InList
//
//  Created by Idris on 14/04/25.
//

import Foundation
import Moya

protocol HomeServiceProtocol {
	func getInsuranceList(onSuccess: (([InsuranceModel]) -> Void)?, onFailure: ((Error) -> Void)?)
}

class HomeService: HomeServiceProtocol, APIMappingProtocol {
	private let provider: MoyaProvider<InsuranceProvider>
	
	init(provider: MoyaProvider<InsuranceProvider> = MoyaProvider<InsuranceProvider>()) {
		self.provider = provider
	}
	
	func getInsuranceList(onSuccess: (([InsuranceModel]) -> Void)?, onFailure: ((Error) -> Void)?) {
		provider.request(.getInsuranceList) { [weak self] result in
			self?.handleResult(result, typeResponse: InsuranceModel.self, onSuccess: onSuccess, onFailure: onFailure)
		}
	}
}

//
//  InsuranceProvider.swift
//  InList
//
//  Created by Idris on 14/04/25.
//

import Foundation
import Moya

enum InsuranceProvider {
	case getInsuranceList
}

extension InsuranceProvider: TargetType {
	var baseURL: URL {
		return URL(string: "https://jsonplaceholder.typicode.com/posts")!
	}
	
	var path: String {
		switch self {
		case .getInsuranceList:
			return ""
		}
	}
	
	var method: Moya.Method {
		return .get
	}
	
	var task: Task {
		var data: [String:Any] = [:]
		switch self {
		case .getInsuranceList:
			return .requestPlain
		}
	}
	
	var headers: [String : String]? {
		return [
			"Content-Type": "application/json"
		]
	}
}

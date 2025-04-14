//
//  InsuranceDetailViewController.swift
//  InList
//
//  Created by Idris on 15/04/25.
//

import UIKit

class InsuranceDetailViewController: UIViewController {
	
	// MARK: - Outlets
	@IBOutlet weak var insuranceBody: UILabel!
	@IBOutlet weak var insuranceTitle: UILabel!
	@IBOutlet weak var insuranceClaimID: UILabel!
	
	var insurance: InsuranceCellModel?

    override func viewDidLoad() {
        super.viewDidLoad()
		setupLabel()
    }
	
	func setupLabel() {
		if let insurance = insurance {
			title = "Detail Asuransi"
			insuranceBody.text = insurance.body
			insuranceTitle.text = insurance.title
		}
	}
}

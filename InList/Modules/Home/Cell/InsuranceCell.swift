//
//  InsuranceCell.swift
//  InList
//
//  Created by Idris on 14/04/25.
//

import UIKit

class InsuranceCell: UITableViewCell {

	@IBOutlet weak var insuranceBody: UILabel!
	@IBOutlet weak var insuranceTitle: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	func setupCell(insurance: InsuranceCellModel) {
		insuranceTitle.text = insurance.title
		insuranceBody.text = insurance.body
	}
}

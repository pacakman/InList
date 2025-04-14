//
//  UITableViewController+Extension.swift
//  InList
//
//  Created by Idris on 14/04/25.
//

import UIKit

extension UITableView {
	func registerNIB(with cellClass: AnyClass) {
		let className = String(describing: cellClass)
		register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
	}
	
	func dequeueCell<T>(with cellClass: T.Type) -> T? {
		return dequeueReusableCell(withIdentifier: String(describing: cellClass)) as? T
	}
}

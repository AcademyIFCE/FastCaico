//
//  UITableViewExtension.swift
//  FastCaico
//
//  Created by Davi Cabral on 10/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit

extension UITableView {
    //Register cell from class reference
    func register(_ cell: UITableViewCell.Type) {
        let nib = UINib(nibName: cell.nibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: cell.reuseIdentifier)
    }
    
    func registerHeader(_ header : UITableViewHeaderFooterView.Type) {
        let nib = UINib(nibName: header.nibName, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: header.reuseIdentifier)
    }
    
    //Dequeue cell from class reference
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError("Could not find cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
    
    func dequeueReusableHeader<T: UITableViewHeaderFooterView>() -> T {
        
        guard let headerView = self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not find header with identifier: \(T.reuseIdentifier)")
        }
        return headerView
    }
}

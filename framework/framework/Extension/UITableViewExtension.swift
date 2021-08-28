//
//  UITableViewExtension.swift
//  busProject
//
//  Created by Pitchaorn on 21/8/2562 BE.
//  Copyright © 2562 Freewillsolutions. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    var indexPathForEditingRow: IndexPath? {
        return indexPathsForEditingRows.first
    }
    
    var indexPathsForEditingRows: [IndexPath] {
        return visibleCells.compactMap { cell -> IndexPath? in
            guard let indexPath = indexPath(for: cell), cell.editingStyle != .none else {
                return nil
            }
            return indexPath
        }
    }
    
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }
        
        return lastIndexPath == indexPath
    }
}


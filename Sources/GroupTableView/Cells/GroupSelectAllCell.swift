//
//  GroupSelectAllCell.swift
//  
//
//  Created by Zach Eriksen on 12/3/20.
//

import UIKit
import SwiftUIKit

class GroupSelectAllCell: TableViewCell {
    var label = Label.headline("")
    
    func configure(forData data: CellDisplayable) {
        
        selectionStyle = .none
        
        contentView.clear().center {
            label
        }
        
    }
    
    func update(forData data: CellDisplayable) {
        guard let data = data as? GroupSelectAllCellData else {
            return
        }
        
        label.text = (data.isSelected ? "DESELECT" : "SELECT") + data.title
    }
    
    static var ID: String {
        "selectAll"
    }
}

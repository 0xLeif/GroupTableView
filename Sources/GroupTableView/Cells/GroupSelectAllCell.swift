//
//  GroupSelectAllCell.swift
//  
//
//  Created by Zach Eriksen on 12/3/20.
//

import UIKit
import SwiftUIKit

public class GroupSelectAllCell: TableViewCell {
    public var label = Label.headline("")
    
    public func configure(forData data: CellDisplayable) {
        
        selectionStyle = .none
        
        contentView.clear().center {
            label
        }
        
    }
    
    public func update(forData data: CellDisplayable) {
        guard let data = data as? GroupSelectAllCellData else {
            return
        }
        
        label.text = (data.isSelected ? "DESELECT" : "SELECT") + data.title
    }
    
    public static var ID: String {
        "selectAll"
    }
}

//
//  GroupSelectionCellData.swift
//  
//
//  Created by Zach Eriksen on 12/3/20.
//

import SwiftUIKit

struct GroupSelectionCellData: CellDisplayable {
    var cellID: String {
        GroupSelectionCell.ID
    }
    
    var id: String
    
    var title: String
    var iconURL: String? = nil
    var isSelected: Bool = false
}

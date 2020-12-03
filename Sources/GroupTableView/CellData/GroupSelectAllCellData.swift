//
//  GroupSelectAllCellData.swift
//  
//
//  Created by Zach Eriksen on 12/3/20.
//

import SwiftUIKit

struct GroupSelectAllCellData: CellDisplayable {
    var cellID: String {
        GroupSelectAllCell.ID
    }
    
    var groupID: String
    
    var title: String
    var isSelected: Bool = false
}

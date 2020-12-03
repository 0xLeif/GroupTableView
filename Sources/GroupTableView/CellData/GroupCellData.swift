//
//  GroupCellData.swift
//  
//
//  Created by Zach Eriksen on 12/3/20.
//

import SwiftUIKit

struct GroupCellData: CellDisplayable {
    var cellID: String {
        GroupCell.ID
    }
    
    var id: String
    
    var title: String
    var items: [GroupSelectionCellData] = []
    var isExpanded: Bool = false
    
    var selectAllCell: GroupSelectAllCellData {
        GroupSelectAllCellData(groupID: id,
                               title: " ALL \(title.uppercased()) TEAMS",
                               isSelected: items.filter(\.isSelected).count == items.count)
    }
    
    init(
        id: String,
        title: String,
        items: [GroupSelectionCellData] = [],
        isExpanded: Bool = false
    ) {
        self.id = id
        self.title = title
        self.items = items
        self.isExpanded = isExpanded
    }
}

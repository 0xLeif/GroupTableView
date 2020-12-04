//
//  GroupCellData.swift
//  
//
//  Created by Zach Eriksen on 12/3/20.
//

import SwiftUIKit

public struct GroupCellData: CellDisplayable {
    public var cellID: String {
        GroupCell.ID
    }
    
    public var id: String
    
    public var title: String
    public  var items: [GroupSelectionCellData] = []
    public var isExpanded: Bool = false
    
    public var selectAllCell: GroupSelectAllCellData {
        GroupSelectAllCellData(groupID: id,
                               title: " ALL \(title.uppercased()) TEAMS",
                               isSelected: items.filter(\.isSelected).count == items.count)
    }
    
    public init(
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

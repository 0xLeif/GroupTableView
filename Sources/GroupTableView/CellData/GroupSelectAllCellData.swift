//
//  GroupSelectAllCellData.swift
//  
//
//  Created by Zach Eriksen on 12/3/20.
//

import SwiftUIKit

public struct GroupSelectAllCellData: CellDisplayable {
    public var cellID: String {
        GroupSelectAllCell.ID
    }
    
    public var groupID: String
    
    public var title: String
    public var isSelected: Bool = false
    
    public init(
        groupID: String,
        title: String,
        isSelected: Bool = false
    ) {
        self.groupID = groupID
        self.title = title
        self.isSelected = isSelected
    }
}

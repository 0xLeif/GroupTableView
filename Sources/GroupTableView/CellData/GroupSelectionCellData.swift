//
//  GroupSelectionCellData.swift
//  
//
//  Created by Zach Eriksen on 12/3/20.
//

import SwiftUIKit

public struct GroupSelectionCellData: CellDisplayable {
    public var cellID: String {
        GroupSelectionCell.ID
    }
    
    public var id: String
    
    public var title: String
    public var iconURL: String? = nil
    public var isSelected: Bool = false
    
    public init(
        id: String,
        title: String,
        iconURL: String? = nil,
        isSelected: Bool = false
    ) {
        self.id = id
        self.title = title
        self.iconURL = iconURL
        self.isSelected = isSelected
    }
}

//
//  GroupSelectionCell.swift
//  
//
//  Created by Zach Eriksen on 12/3/20.
//

import UIKit
import SwiftUIKit

public class GroupSelectionCell: TableViewCell {
    public var cellIcon = Image("ic_star")
        .contentMode(.scaleAspectFit)
        .templateImage()
        .tint(color: .systemRed)
    public var label = Label("")
    public var checkMarkImage = Image("ic_check")
        .contentMode(.scaleAspectFill)
        .templateImage()
        .tint(color: .systemRed)
    
    public func configure(forData data: CellDisplayable) {
        guard data is GroupSelectionCellData else {
            return
        }
        
        selectionStyle = .none
        
        contentView.clear()
            .hstack(withSpacing: 16, padding: 16) {
                [
                    cellIcon,
                    label,
                    Spacer(),
                    checkMarkImage
                        .padding()
                ]
            }
            .frame(height: 60)
    }
    
    public func update(forData data: CellDisplayable) {
        guard let data = data as? GroupSelectionCellData else {
            return
        }
        
        label.text = data.title
        
        if data.isSelected {
            checkMarkImage.appear(withAnimatedDuration: 0.25)
        } else {
            checkMarkImage.hidden(withAnimatedDuration: 0.25)
        }
    }
    
    public static var ID: String {
        "selection"
    }
}

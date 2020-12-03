//
//  GroupSelectionCell.swift
//  
//
//  Created by Zach Eriksen on 12/3/20.
//

import UIKit
import SwiftUIKit

class GroupSelectionCell: TableViewCell {
    var cellIcon = Image("ic_star")
        .contentMode(.scaleAspectFit)
        .templateImage()
        .tint(color: .systemRed)
    var label = Label("")
    var checkMarkImage = Image("ic_check")
        .contentMode(.scaleAspectFill)
        .templateImage()
        .tint(color: .systemRed)
    
    func configure(forData data: CellDisplayable) {
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
    
    func update(forData data: CellDisplayable) {
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
    
    static var ID: String {
        "selection"
    }
}

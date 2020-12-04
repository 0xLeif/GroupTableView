//
//  GroupCell.swift
//  
//
//  Created by Zach Eriksen on 12/3/20.
//

import UIKit
import SwiftUIKit

public class GroupCell: TableViewCell {
    public static var updateHandler: ((GroupCellData, Int) -> Void)?
    
    public var cellIcon = Image("ic_star")
        .contentMode(.scaleAspectFit)
        .templateImage()
        .tint(color: .systemRed)
    public var label = Label("")
    public var arrowImage = Image("ic_arrow")
        .contentMode(.scaleAspectFit)
        .templateImage()
        .tint(color: .systemRed)
    
    public var selectedLabel = Label("X/Y Selected")
    
    public var tableView = TableView().register(cells: [GroupSelectAllCell.self, GroupSelectionCell.self])
    public var innerView = UIView()
    
    public func configure(forData data: CellDisplayable) {
        guard let data = data as? GroupCellData else {
            return
        }
        
        selectionStyle = .none
        
        innerView.clear()
            .embed(withPadding: [.leading(64),
                                 .top(0),
                                 .bottom(0),
                                 .trailing(0)]) {
                tableView
            }
        
        contentView.clear().vstack {
            [
                HStack(withSpacing: 16, padding: 16) {
                    [
                        cellIcon,
                        label,
                        arrowImage,
                        Spacer(),
                        selectedLabel
                    ]
                }
                .frame(height: 60),
                Spacer(),
                innerView
                    .frame(height: 0)
            ]
        }
        
        update(forData: data)
    }
    
    public func update(forData data: CellDisplayable) {
        guard let data = data as? GroupCellData else {
            return
        }
        
        let selectedCount = data.items.filter(\.isSelected).count
        
        selectedLabel.text = "\(selectedCount)/\(data.items.count) Selected"
        
        if data.isExpanded {
            arrowImage.transform { _ in
                CGAffineTransform.identity
            }
            innerView.isHidden = false
        } else {
            arrowImage.transform { _ in
                CGAffineTransform.identity.rotated(by: .pi / 2)
            }
            innerView.isHidden = true
        }
        
        print("Update Group: \(data)")
        let cells: [CellDisplayable] = [data.selectAllCell] + data.items
        
        label.text = data.title
        innerView.update(height: Float(data.items.count + 1) * 60)
        
        tableView.update(shouldReloadData: true) { _ in
            [
                cells
            ]
        }.didSelectRow { (path) in
            GroupCell.updateHandler?(data, path.row)
        }
    }
    
    public static var ID: String {
        "group"
    }
}

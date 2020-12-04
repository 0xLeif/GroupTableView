//
//  GroupTableView.swift
//
//
//  Created by Zach Eriksen on 12/3/20.
//

import UIKit
import SwiftUIKit

public enum GroupCellType {
    case group(cell: GroupCellData)
    case selection(cell: GroupSelectionCellData)
}

public class GroupTableView: UIView {
    public var items: [GroupCellType] = [
        .group(cell: GroupCellData(id: "f01", title: "Football", items: [GroupSelectionCellData(id: "", title: "First and Only")])),
        .group(cell: GroupCellData(id: "f02", title: "Football", items: [
            GroupSelectionCellData(id: "", title: "First"),
            GroupSelectionCellData(id: "", title: "2nd"),
            GroupSelectionCellData(id: "", title: "th3rd"),
            GroupSelectionCellData(id: "", title: "4th"),
            GroupSelectionCellData(id: "", title: "5", isSelected: true),
        ], isExpanded: true)),
        .selection(cell: GroupSelectionCellData(id: "team_leif_01", title: "Team Leif")),
        .selection(cell: GroupSelectionCellData(id: "team_leif_02", title: "Team Leif", isSelected: true)),
        .selection(cell: GroupSelectionCellData(id: "Some", title: "Some")),
        .selection(cell: GroupSelectionCellData(id: "Some", title: "Some")),
        .selection(cell: GroupSelectionCellData(id: "Some", title: "Some")),
        .selection(cell: GroupSelectionCellData(id: "Some", title: "Some")),
        .selection(cell: GroupSelectionCellData(id: "Some", title: "Some")),
        .selection(cell: GroupSelectionCellData(id: "Some", title: "Some")),
        .selection(cell: GroupSelectionCellData(id: "Some", title: "Some")),
        .selection(cell: GroupSelectionCellData(id: "Some", title: "Some")),
        .selection(cell: GroupSelectionCellData(id: "Some", title: "Some")),
        .selection(cell: GroupSelectionCellData(id: "Some", title: "Some")),
        .selection(cell: GroupSelectionCellData(id: "Some", title: "Some")),
        .selection(cell: GroupSelectionCellData(id: "Some", title: "Some")),
        .selection(cell: GroupSelectionCellData(id: "Some", title: "Some")),
        .selection(cell: GroupSelectionCellData(id: "Some", title: "Some")),
        .selection(cell: GroupSelectionCellData(id: "Some", title: "Some")),
        .selection(cell: GroupSelectionCellData(id: "Some", title: "Some")),
        .group(cell: GroupCellData(id: "s03", title: "Some Sport", items: [
            GroupSelectionCellData(id: "", title: "First"),
            GroupSelectionCellData(id: "", title: "2nd"),
            GroupSelectionCellData(id: "", title: "th3rd"),
            GroupSelectionCellData(id: "", title: "4th"),
            GroupSelectionCellData(id: "", title: "5", isSelected: true),
        ], isExpanded: true)),
    ]
    
    private var data: [[CellDisplayable]] {
        [
            items.map { item in
                switch item {
                case .group(let cell):
                    return cell
                case .selection(let cell):
                    return cell
                }
            }
        ]
    }
    
    private var tableView = TableView()
    
    public init() {
        super.init(frame: .zero)
        
        GroupCell.updateHandler = { [weak self] (data, itemIndex) in
            print("Update: \(data) at \(itemIndex)")
            self?.handle(groupCell: data, row: itemIndex)
        }
        
        embed {
            tableView
                .register(cells: [
                    GroupCell.self,
                    GroupSelectionCell.self,
                    GroupSelectAllCell.self
                ])
                .update(shouldReloadData: true) { _ in
                    data
                }
                .didSelectRow { [unowned self] (path) in
                    print("Item Selected: \(self.items[path.row])")
                    self.handle(didSelectRowAtIndexPath: path)
                }
        }
    }
    
    public func handle(didSelectRowAtIndexPath indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
        
        switch selectedItem {
        case .group(let cell):
            var updatedCell = cell
            updatedCell.isExpanded = !cell.isExpanded
            print("Cell isExpanded: \(updatedCell.isExpanded)")
            items[indexPath.row] = .group(cell: updatedCell)
        case .selection(let cell):
            var updatedCell = cell
            updatedCell.isSelected = !cell.isSelected
            print("Cell isSelected: \(updatedCell.isSelected)")
            items[indexPath.row] = .selection(cell: updatedCell)
        }
        
        tableView
            .update { _ in
                data
            }
            .reloadRows(at: [indexPath], with: .automatic)
    }
    
    public func handle(groupCell: GroupCellData, row: Int) {
        guard row > 0 else {
            print("This should select/ deselect all options under this group")
            
            guard let index = items.firstIndex(where: { item in
                guard case .group(let cell) = item,
                      cell.id == groupCell.id else {
                    return false
                }
                return true
            }),
            case .group(var cell) = items[index] else {
                return
            }
            
            let isSelected = !cell.selectAllCell.isSelected
            groupCell.items.enumerated().forEach { (index, item) in
                var updatedItem = item
                
                updatedItem.isSelected = isSelected
                
                cell.items[index] = updatedItem
            }
            
            items[index] = .group(cell: cell)
            
            tableView
                .update { _ in
                    data
                }
                .reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            
            return
        }
        let prevRow = row - 1
        
        print("PrevRow: \(prevRow)")
        print("Count: \(groupCell.items.count)")
        
        var updatedCell = groupCell.items[prevRow]
        updatedCell.isSelected = !updatedCell.isSelected
        
        guard let index = items.firstIndex(where: { item in
            guard case .group(let cell) = item,
                  cell.id == groupCell.id else {
                return false
            }
            return true
        }) else {
            return
        }
        
        guard case .group(var cell) = items[index] else {
            return
        }
        print("Updated: \(updatedCell)")
        
        print("Before: \(cell.items[prevRow])")
        
        cell.items[prevRow] = updatedCell
        
        print("After: \(cell.items[prevRow])")
        
        items[index] = .group(cell: cell)
        
        print("Final: \(items[index])")
        
        tableView
            .update { _ in
                data
            }
            .reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  SourceViewController.swift
//  Storm Viewer
//
//  Created by Samantha Gatt on 6/9/19.
//  Copyright © 2019 Samantha Gatt. All rights reserved.
//

import Cocoa

class SourceViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var tableView: NSTableView!
    
    var pictures: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let path = Bundle.main.resourcePath,
            let items = try? FileManager.default.contentsOfDirectory(atPath: path) else { return }
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return pictures.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let identifier = tableColumn?.identifier,
            let cell = tableView.makeView(withIdentifier: identifier, owner: self) as? NSTableCellView else { return nil }
        cell.textField?.stringValue = pictures[row]
        return cell
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        guard tableView.selectedRow != -1 else { return }
        guard let splitVC = parent as? NSSplitViewController else { return }
        if splitVC.children.count > 1, let detailVC = splitVC.children[1] as? DetailViewController {
            detailVC.imageSelected(pictures[tableView.selectedRow])
        }
    }
}

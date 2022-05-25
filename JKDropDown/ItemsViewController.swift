//
//  PopupViewController.swift
//  Sample Project
//
//  Created by Julia Konkova on 24.05.2022.
//

import Foundation
import UIKit

class ItemsViewController: UIViewController {
    
    private(set) var items: [DropDownItem]
    var selectedItem: DropDownItem?
    var onItemSelected: ((DropDownItem) -> ())?
    
    var backgroundColor: UIColor = .secondarySystemBackground
    var tintColor: UIColor?
    var separatorColor: UIColor?
    var itemMargins: UIEdgeInsets?
    var itemTitleFont: UIFont?
    var itemSubtitleFont: UIFont?
    var itemTitleColor: UIColor?
    var itemSubtitleColor: UIColor?
    var checkSelectedItem = false
    
    private var tableView: UITableView!

    init(items: [DropDownItem]) {
        self.items = items
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = UIView()
        addTableView()
        customizeAppearance()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        preferredContentSize = CGSize(width: view.frame.width, height: preferredHeight)
    }
    
    private var preferredHeight: CGFloat {
        if items.isEmpty {
            return 40;
        }
        
        var height: CGFloat = 0
        let screenHeight = UIScreen.main.bounds.height
        
        for i in 0 ..< items.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cellHeight = tableView.rectForRow(at: indexPath).height
            height = height + cellHeight
            if height > screenHeight {
                break;
            }
        }
        
        return height;
    }
    
    private func addTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = nil
        tableView.bounces = false
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)

        let top = NSLayoutConstraint(item: tableView!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: tableView!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: tableView!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: tableView!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([trailing, leading, bottom, top])
    }
    
    private func customizeAppearance() {
        tableView.backgroundColor = backgroundColor
        
        if let tintColor = tintColor {
            tableView.tintColor = tintColor
        }
        
        if let separatorColor = separatorColor {
            tableView.separatorColor = separatorColor
        }
    }
}

extension ItemsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "ItemCell") ?? Bundle.main.loadNibNamed("ItemCell", owner: self)?.first) as! ItemCell

        let item = items[indexPath.row]
        cell.item = item
        cell.margins = itemMargins
        cell.titleColor = itemTitleColor
        cell.subtitleColor = itemSubtitleColor
        cell.titleFont = itemTitleFont
        cell.subtitleFont = itemSubtitleFont
        cell.backgroundColor = backgroundColor
        cell.accessoryType = (checkSelectedItem && selectedItem?.id == item.id) ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            self.onItemSelected?(self.items[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//
//  DropDownView.swift
//  Sample Project
//
//  Created by Julia Konkova on 24.05.2022.
//

import Foundation
import UIKit

class DropDownView: UIControl {
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var arrowImageView: UIImageView!
    @IBOutlet private weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingConstraint: NSLayoutConstraint!
    
    private var view: UIView!
    private var popupWidth: CGFloat = 0
    
    var items = [DropDownItem]() {
        didSet {
            calculatePopupWidth()
        }
    }
    var selectedItem: DropDownItem? {
        didSet {
            updateLabel()
        }
    }
    var onSelectionChanged: ((DropDownItem) -> ())?
    
    var alwaysOpenDown = false
    var checkSelectedItem = false
    
    var font: UIFont = UIFont.systemFont(ofSize: 17) {
        didSet {
            label.font = font
        }
    }
    
    var itemTitleFont = UIFont.systemFont(ofSize: 15) {
        didSet {
            calculatePopupWidth()
        }
    }
    var itemSubtitleFont = UIFont.systemFont(ofSize: 13) {
        didSet {
            calculatePopupWidth()
        }
    }
    
    @IBInspectable var textColor: UIColor? {
        didSet {
            if textColor != nil {
                updateLabel()
            }
        }
    }
    @IBInspectable var itemTitleColor: UIColor?
    @IBInspectable var itemSubtitleColor: UIColor?
    @IBInspectable var itemBackgroundColor = UIColor.secondarySystemBackground
    @IBInspectable var separatorColor: UIColor?
    
    @IBInspectable var arrowColor: UIColor = .label {
        didSet {
            arrowImageView.tintColor = arrowColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.masksToBounds = true
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var leftMargin: CGFloat  = 16 {
        didSet {
            leadingConstraint.constant = leftMargin
        }
    }
    
    @IBInspectable var rightMargin: CGFloat  = 16 {
        didSet {
            trailingConstraint.constant = rightMargin
        }
    }
    
    var itemMargins: UIEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16) {
        didSet {
            calculatePopupWidth()
        }
    }
    
    @IBInspectable var placeholderColor: UIColor = .secondaryLabel {
        didSet {
            updateLabel()
        }
    }
    
    @IBInspectable var placeholder: String? {
        didSet {
            updateLabel()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        view = xibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        view = xibSetup()
    }
    
    private func updateLabel() {
        if let item = selectedItem {
            label.text = item.title
            label.textColor = textColor
        } else {
            label.textColor = placeholderColor
            label.text = placeholder
        }
    }
    
    private func calculatePopupWidth() {
        if items.isEmpty {
            return
        }
        
        var maxItemLineWidth: CGFloat = 0
        for i in 0 ..< items.count {
            let item = items[i]
            let titleWidth = item.title.lineWidth(font: itemTitleFont)
            var subtitleWidth: CGFloat = 0
            if let subtitle = item.subtitle {
                subtitleWidth = subtitle.lineWidth(font: itemSubtitleFont)
            }
            let lineWidth = max(titleWidth, subtitleWidth)
            if lineWidth > maxItemLineWidth {
                maxItemLineWidth = lineWidth
            }
        }
        
        popupWidth = maxItemLineWidth + itemMargins.left + itemMargins.right
        popupWidth = max(popupWidth, view.bounds.size.width)
    }
    
    @IBAction func tapped(_ sender: Any) {
        let vc = createItemsViewController()
        
        let popover = vc.popoverPresentationController
        popover?.permittedArrowDirections = alwaysOpenDown ? .up : [.up, .down]
        popover?.sourceView = view
        popover?.sourceRect = view.bounds
        popover?.delegate = self
        
        parentViewController?.present(vc, animated: false)
        vc.preferredContentSize = CGSize(width: popupWidth, height: 0)
    }
    
    func createItemsViewController() -> ItemsViewController {
        let vc = ItemsViewController(items: items)
        vc.modalPresentationStyle = .popover
        vc.selectedItem = selectedItem
        vc.tintColor = tintColor
        vc.checkSelectedItem = checkSelectedItem
        vc.itemTitleFont = itemTitleFont
        vc.itemSubtitleFont = itemSubtitleFont
        vc.itemMargins = itemMargins
        vc.itemTitleColor = itemTitleColor
        vc.itemSubtitleColor = itemSubtitleColor
        vc.backgroundColor = itemBackgroundColor
        vc.separatorColor = separatorColor
        vc.onItemSelected = {[unowned self] item in
            self.selectedItem = item
            self.onSelectionChanged?(item)
        }
        return vc
    }
}

extension DropDownView: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

//
//  DropDownCell.swift
//  Sample Project
//
//  Created by Julia Konkova on 24.05.2022.
//

import Foundation
import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var titleBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var subtitleBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    
    var item: DropDownItem! {
        didSet {
            titleLabel.text = item.title
            subtitleLabel.text = item.subtitle
            
            let noSubtitle = item.subtitle?.isEmpty ?? true
            subtitleLabel.isHidden = noSubtitle
            titleBottomConstraint.priority = (noSubtitle ? .defaultHigh : .defaultLow)
            subtitleBottomConstraint.priority = (noSubtitle ? .defaultLow : .defaultHigh)
        }
    }
    
    var margins: UIEdgeInsets? {
        didSet {
            if let margins = margins {
                topConstraint.constant = margins.top
                leadingConstraint.constant = margins.left
                titleBottomConstraint.constant = margins.bottom
                subtitleBottomConstraint.constant = margins.bottom
                trailingConstraint.constant = margins.right
            }
        }
    }
    
    var titleFont: UIFont? {
        didSet {
            if let font = titleFont {
                titleLabel.font = font
            }
        }
    }
    
    var subtitleFont: UIFont? {
        didSet {
            if let font = subtitleFont {
                subtitleLabel.font = font
            }
        }
    }
    
    var titleColor: UIColor? {
        didSet {
            if let color = titleColor {
                titleLabel.textColor = color
            }
        }
    }
    
    var subtitleColor: UIColor? {
        didSet {
            if let color = subtitleColor {
                subtitleLabel.textColor = color
            }
        }
    }
}

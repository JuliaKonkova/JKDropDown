//
//  String+Extensions.swift
//  Sample Project
//
//  Created by Julia Konkova on 24.05.2022.
//

import Foundation
import UIKit

extension String {
    func lineWidth(font: UIFont) -> CGFloat {
        let attrs: [NSAttributedString.Key: Any] = [.font: font]
        let attrStr = NSAttributedString(string: self, attributes: attrs)
        return attrStr.size().width
    }
}

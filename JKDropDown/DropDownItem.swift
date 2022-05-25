//
//  DropDownItem.swift
//  Sample Project
//
//  Created by Julia Konkova on 24.05.2022.
//

import Foundation

protocol DropDownItem {
    var id: String { get }
    var title: String { get }
    var subtitle: String? { get }
}

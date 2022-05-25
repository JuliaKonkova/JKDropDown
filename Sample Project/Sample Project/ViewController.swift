//
//  ViewController.swift
//  Sample Project
//
//  Created by Julia Konkova on 24.05.2022.
//

import UIKit

struct Capital: DropDownItem {
    let city: String
    let country: String
    
    var title: String {
        return city
    }
    
    var subtitle: String? {
        return country
    }
    
    var id: String {
        return "\(city)_\(country)"
    }
}

struct Number: DropDownItem {
    let number: Int
    
    var title: String {
        return "\(number)"
    }
    
    var subtitle: String? {
        return nil
    }
    var id: String {
        return "\(number)"
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var dropDown1: DropDownView!
    @IBOutlet weak var dropDown2: DropDownView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropDown1.font = UIFont.boldSystemFont(ofSize: 17)
        dropDown1.alwaysOpenDown = true
        dropDown1.items = [Capital(city: "Moscow", country: "Russian Federation"), Capital(city: "Minsk", country: "Belarus")]

        dropDown2.itemTitleFont = UIFont.boldSystemFont(ofSize: 15)
        dropDown2.itemMargins = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        dropDown2.checkSelectedItem = true
        let item1 = Number(number: 1)
        var items = [item1]
        items.append(contentsOf: (2 ... 30).map { Number(number: $0) })
        dropDown2.items = items
        dropDown2.selectedItem = item1
    }


}


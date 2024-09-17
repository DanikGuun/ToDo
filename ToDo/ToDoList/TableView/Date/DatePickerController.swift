//
//  DatePickerController.swift
//  ToDo
//
//  Created by Данила Бондарь on 17.09.2024.
//

import Foundation
import UIKit

class DatePickerController: UIViewController{
    
    var delegate: DatePickerDelegate?
    var startDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let picker = UICalendarView()
        self.view.addSubview(picker)
        picker.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}

protocol DatePickerDelegate{
    
}

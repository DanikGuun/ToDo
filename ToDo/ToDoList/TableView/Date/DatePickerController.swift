//
//  DatePickerController.swift
//  ToDo
//
//  Created by Данила Бондарь on 17.09.2024.
//

import Foundation
import UIKit

class DatePickerController: UIViewController, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate{
    
    var delegate: DatePickerDelegate?
    var startDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let picker = UICalendarView()
        self.view.addSubview(picker)
        picker.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        let comps = Calendar.current.dateComponents([.year, .month, .day], from: startDate)
        picker.setVisibleDateComponents(comps, animated: true)
        picker.delegate = self
        picker.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        if let dateComponents { delegate?.pickDate(date: dateComponents) }
        dismiss(animated: true)
    }
    
}

protocol DatePickerDelegate{
    func pickDate(date: DateComponents)
}

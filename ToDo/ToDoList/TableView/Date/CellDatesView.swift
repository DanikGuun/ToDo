//
//  CellDatesView.swift
//  ToDo
//
//  Created by Данила Бондарь on 16.09.2024.
//

import Foundation
import UIKit

class CellDatesView: UIView, TimeButtonDelegate, DateButtonDelegate{

    private var viewController: UIViewController?{
        var responder: UIResponder? = self.next
        while responder != nil{
            if let controller = responder as? UIViewController {
                return controller
            }
            responder = responder?.next
        }
        return nil
    }
    var delegate: CellDatesViewDelegate?
    
    let datePickerButton = DateButton()
    var startDate = Date() {
        didSet {
            startTimeButton.date = startDate
            datePickerButton.currentDate = Calendar.current.dateComponents([.year, .month, .day], from: startDate)
        }
    }
    var endDate = Date() { didSet { endTimeButton.date = endDate } }
    
    private let startTimeButton = TimeButton()
    private let endTimeButton = TimeButton()
    
    //Initialize
    convenience init() {
        self.init(frame: .zero)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        datePickerButton.delegate = self
        self.addSubview(datePickerButton)
        datePickerButton.snp.makeConstraints { maker in
            maker.centerY.leading.equalToSuperview()
        }
        
        
        self.addSubview(startTimeButton)
        startTimeButton.type = .start
        startTimeButton.setTime(from: startDate)
        startTimeButton.delegate = self
        startTimeButton.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.leading.equalTo(datePickerButton.snp.trailing)
        }
        
        self.addSubview(endTimeButton)
        endTimeButton.type = .end
        endTimeButton.setTime(from: endDate)
        endTimeButton.delegate = self
        endTimeButton.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.leading.equalTo(startTimeButton.snp.trailing)
        }
        
        
        let timeSeparator = UILabel()
        self.addSubview(timeSeparator)
        timeSeparator.text = "-"
        timeSeparator.textColor = .systemGray3
        timeSeparator.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.leading.equalTo(startTimeButton.snp.trailing)
            maker.trailing.equalTo(endTimeButton.snp.leading)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //Delegates
    func timeButton(timeButton: TimeButton, selectedDate date: Date, type: TimeButtonType) {
        if type == .start {
            let comps = Calendar.current.dateComponents([.hour, .minute], from: date)
            endTimeButton.minTime = comps
            delegate?.cellDatesView(withStartDate: date)
        }
        else if type == .end { delegate?.cellDatesView(withEndDate: date) }
    }
    func dateButton(pickDay date: DateComponents) {
        var startComps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.startDate)
        startComps.year = date.year
        startComps.month = date.month
        startComps.day = date.day
        self.startDate = Calendar.current.date(from: startComps)!
        delegate?.cellDatesView(withStartDate: self.startDate)
        
        var endComps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.startDate)
        endComps.year = date.year
        endComps.month = date.month
        endComps.day = date.day
        self.endDate = Calendar.current.date(from: endComps)!
        delegate?.cellDatesView(withEndDate: self.endDate)
    }
}

protocol CellDatesViewDelegate{
    func cellDatesView(withStartDate date: Date)
    func cellDatesView(withEndDate date: Date)
}

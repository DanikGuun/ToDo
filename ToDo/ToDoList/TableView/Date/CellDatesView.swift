//
//  CellDatesView.swift
//  ToDo
//
//  Created by Данила Бондарь on 16.09.2024.
//

import Foundation
import UIKit

class CellDatesView: UIView{

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
    var startDate = Date()
    var endDate = Date()
    
    //Initialize
    convenience init() {
        self.init(frame: .zero)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let datePickerButton = DateButton()
        self.addSubview(datePickerButton)
        datePickerButton.snp.makeConstraints { maker in
            maker.centerY.leading.equalToSuperview()
        }
        
        let startTimeButton = TimeButton()
        self.addSubview(startTimeButton)
        startTimeButton.type = .start
        startTimeButton.setTime(from: Date())
        startTimeButton.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.leading.equalTo(datePickerButton.snp.trailing)
        }
        
        let endTimeButton = TimeButton()
        self.addSubview(endTimeButton)
        endTimeButton.type = .end
        endTimeButton.setTime(from: Date())
        endTimeButton.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.leading.equalTo(startTimeButton.snp.trailing)
        }
        //Чтобы не заканчивалось раньше начинания
        endTimeButton.addAction(UIAction(handler: {_ in
            let comps = Calendar.current.dateComponents([.hour, .minute], from: startTimeButton.date)
            endTimeButton.minTime = comps
        }), for: .touchUpInside)
        
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

    //Date Handling
    func updateDate(){
        
    }
}

//
//  DateButton.swift
//  ToDo
//
//  Created by Данила Бондарь on 17.09.2024.
//

import Foundation
import UIKit

class DateButton: UIButton, DatePickerDelegate{
    
    var currentDate: DateComponents? { didSet { setDateText(date: currentDate) } }
    var delegate: DateButtonDelegate?
    private let todayDate: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    
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
    
    //MARK: - Initialize
    convenience init(){
        self.init(frame: .zero)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        self.configuration = .plain()
        var conf = self.configuration
        self.configuration = conf
        
        self.addAction(UIAction(handler: {_ in
            self.viewController?.performSegue(withIdentifier: "showDatePickerSegue", sender: (self, Date()))
        }), for: .touchUpInside)
        
        if currentDate == nil{
           currentDate = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        }
    }
    //MARK: - Logic
    
    func setDateText(date: DateComponents?){
        if let date{
            var text = ""
            if date.month == todayDate.month && date.year == todayDate.year{
                if date.day == todayDate.day { text = "Сегодня" }
                else if date.day == (todayDate.day ?? 0) + 1 { text = "Завтра" }
                else if date.day == (todayDate.day ?? 0) - 1 { text = "Вчера" }
                else{
                    text = Calendar.current.date(from: date)?.formatted(.dateTime.day(.twoDigits).month(.twoDigits).year()) ?? "fas"
                }
            }
            var attributedString = AttributedString(text)
            attributedString.font = UIFont(name: "Bajazzo-Md", size: 16)
            attributedString.foregroundColor = .systemGray
            
            var conf = self.configuration
            conf?.attributedTitle = attributedString
            self.configuration = conf
        }
    }
    
    func pickDate(date: DateComponents) {
        setDateText(date: date)
        currentDate = date
        delegate?.dateButton(pickDay: date)
    }
}
protocol DateButtonDelegate{
    func dateButton(pickDay date: DateComponents)
}

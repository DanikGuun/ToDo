//
//  TimePickerButton.swift
//  ToDo
//
//  Created by Данила Бондарь on 17.09.2024.
//

import Foundation
import UIKit

class TimeButton: UIButton, TimePickerViewDelegate{
    
    var date = Date()
    var minTime: DateComponents?
    var type: TimeButtonType = .start
    private var hour: Int {
        Calendar.current.component(.hour, from: date)
    }
    private var minute: Int {
        Calendar.current.component(.minute, from: date)
    }
    
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
        self.addAction(UIAction(handler: { [unowned self] _ in
            var comps = DateComponents()
            comps.hour = self.hour
            comps.minute = self.minute
            
            self.viewController?.performSegue(withIdentifier: "showTimePickerSegue", sender: (self, comps, minTime))
        }), for: .touchUpInside)
    }
    
    //MARK: - Logic
    func setTime(from date: Date){
        var startText = ""
        if self.type == .start { startText = "с " }
        else if self.type == .end { startText = "до " }
        var attributedTime = AttributedString(startText + date.formatted(.dateTime.hour().minute()))
        attributedTime.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        attributedTime.foregroundColor = .systemGray3
        var conf = self.configuration
        conf?.attributedTitle = attributedTime
        self.configuration = conf
    }
    
    func timePicker(pickedHours hours: Int, pickedMinutes minutes: Int) {
        let comps = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hourDif = Double((hours - (comps.hour ?? 0)) * 3600)
        let minuteDif = Double(( minutes - (comps.minute ?? 0)) * 60 )
        date = date.addingTimeInterval(hourDif + minuteDif)
        setTime(from: date)
    }
}

enum TimeButtonType{
    case start
    case end
    case none
}

//
//  TimePickerButton.swift
//  ToDo
//
//  Created by Данила Бондарь on 17.09.2024.
//

import Foundation
import UIKit

class TimeButton: UIButton, TimePickerViewDelegate{
    
    private var hour: Int = 0
    private var minute: Int = 0
    
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
        self.addAction(UIAction(handler: { _ in
            let cell = self.superview!.superview!
            let cellCoord = self.convert(self.frame, to: cell)
            let globalFrame = cell.convert(cellCoord, to: nil)
            
            var comps = DateComponents()
            comps.hour = self.hour
            comps.minute = self.minute
            
            self.viewController?.performSegue(withIdentifier: "showTimePickerSegue", sender: (globalFrame, self, comps))
        }), for: .touchUpInside)
    }
    
    //MARK: - Logic
    func setTime(from date: Date){
        let comps = Calendar.current.dateComponents([.hour, .minute], from: date)
        var conf = self.configuration
        conf?.title = "\(comps.hour ?? 0) : \(comps.minute ?? 0)"
        self.configuration = conf
        
        self.hour = comps.hour ?? 0
        self.minute = comps.minute ?? 0
    }
    
    func timePicker(pickedHours hours: Int, pickedMinutes minutes: Int) {
        var conf = self.configuration
        conf?.title = "\(hours) : \(minutes)"
        self.configuration = conf
        
        self.hour = hours
        self.minute = minutes
    }
}

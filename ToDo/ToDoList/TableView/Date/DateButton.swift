//
//  DateButton.swift
//  ToDo
//
//  Created by Данила Бондарь on 17.09.2024.
//

import Foundation
import UIKit

class DateButton: UIButton, DatePickerDelegate{
    
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
        var str = AttributedString("Title")
        str.foregroundColor = UIColor.systemRed
        str.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        conf?.attributedTitle = str
        self.configuration = conf
    
        self.addAction(UIAction(handler: {_ in
            let cell = self.superview!.superview!
            let cellCoord = self.convert(self.frame, to: cell)
            let globalFrame = cell.convert(cellCoord, to: nil)
            
            self.viewController?.performSegue(withIdentifier: "showDatePickerSegue", sender: (globalFrame, self, Date()))
        }), for: .touchUpInside)
    }
}

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
        
        let startTimeButton = TimeButton()
        self.addSubview(startTimeButton)
        startTimeButton.setTime(from: Date())
        startTimeButton.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //Date Handling
    func updateDate(){
        
    }
}

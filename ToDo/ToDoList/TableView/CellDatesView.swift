//
//  CellDatesView.swift
//  ToDo
//
//  Created by Данила Бондарь on 16.09.2024.
//

import Foundation
import UIKit

class CellDatesView: UIView, TimePickerViewDelegate{
    
    //Initialize
    convenience init() {
        self.init(frame: .zero)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let but = UIButton(configuration: .plain())
        self.addSubview(but)
        but.setTitle("Press", for: .normal)
        but.snp.makeConstraints { maker in
            maker.top.bottom.leading.equalToSuperview()
        }
        but.addAction(UIAction(handler: { [unowned self] _ in
            let cell = self.superview!
            let cellCoord = self.convert(but.frame, to: cell)
            let globalFrame = cell.convert(cellCoord, to: nil)
            viewController?.performSegue(withIdentifier: "showTimePickerSegue", sender: (globalFrame, self))
        }), for: .touchUpInside)
        
  
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func timePicker(pickedHours hours: Int, pickedMinutes minutes: Int) {
        print(minutes)
    }
    
}

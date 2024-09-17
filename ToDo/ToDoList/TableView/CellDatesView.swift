//
//  CellDatesView.swift
//  ToDo
//
//  Created by Данила Бондарь on 16.09.2024.
//

import Foundation
import UIKit

class CellDatesView: UIView, UIPopoverPresentationControllerDelegate{

    var viewController: UIViewController?{
        var responder: UIResponder? = self.next
        while responder != nil{
            if let controller = responder as? UIViewController {
                return controller
            }
            responder = responder?.next
        }
        return nil
    }
    
    //Initialize
    convenience init() {
        self.init(frame: .zero)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let but = UIButton(configuration: .borderedProminent())
        self.addSubview(but)
        but.setTitle("Press", for: .normal)
        but.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        but.addAction(UIAction(handler: { [unowned self] _ in
            let cell = self.superview!
            let globalFrame = cell.convert(self.frame, to: nil)
            viewController?.performSegue(withIdentifier: "showTimePickerSegue", sender: globalFrame)
        }), for: .touchUpInside)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Popover чтобы одинаково показывался на всех устройствах

}

//
//  TimePickerViewController.swift
//  ToDo
//
//  Created by Данила Бондарь on 17.09.2024.
//

import Foundation
import UIKit

class TimePickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    var delegate: TimePickerViewDelegate?
    var startTime: DateComponents?
    
    //MARK: - Initialize
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        self.view.addSubview(picker)
        picker.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        let dotLabel = UILabel()
        self.view.addSubview(dotLabel)
        dotLabel.text = ":"
        dotLabel.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
        if let startTime{
            picker.selectRow(startTime.hour ?? 0, inComponent: 0, animated: true)
            picker.selectRow(startTime.minute ?? 0, inComponent: 1, animated: true)
        }
    }
    
    //MARK: - Picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 { return 23 }
        return 59
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return row.description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let hours = pickerView.selectedRow(inComponent: 0)
        let minutes = pickerView.selectedRow(inComponent: 1)
        delegate?.timePicker(pickedHours: hours, pickedMinutes: minutes)
    }
}

protocol TimePickerViewDelegate{
    func timePicker(pickedHours hours: Int, pickedMinutes minutes: Int)
}

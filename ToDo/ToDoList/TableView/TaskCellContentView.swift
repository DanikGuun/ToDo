//
//  TaskCellContentView.swift
//  ToDo
//
//  Created by Данила Бондарь on 16.09.2024.
//

import Foundation
import UIKit
import SnapKit

class TaskCellContentView: UIView, UIContentView, UITextFieldDelegate, CellDatesViewDelegate{
    
    var configuration: any UIContentConfiguration
    var item: TodoTask?
    var nameField = UITextField()
    var descriptionField = UITextField()
    var isDoneButton = UIButton(configuration: .plain())
    let datesView = CellDatesView()
    
    //MARK: - Initialize
    
    init(configuration conf: TaskCellConfiguration) {
        self.item = conf.item
        self.configuration = conf
        super.init(frame: .zero)
        
        createViews()
    }
    
    func updateConfiguration(_ conf: TaskCellConfiguration){
        //Name Update
        var attributedName = AttributedString(conf.name)
        attributedName.font = UIFont.systemFont(ofSize: 18)
        attributedName.strikethroughStyle = conf.isDone ? NSUnderlineStyle.single : nil
        nameField.attributedText = NSAttributedString(attributedName)
        
        //Description Update
        descriptionField.text = conf.description
        
        isDoneButton.isSelected = conf.isDone
        
        datesView.startDate = conf.startDate
        
        datesView.endDate = conf.endDate
        
        self.item = conf.item
    }
    
    func createViews(){
        
        self.addSubview(nameField)
        self.addSubview(descriptionField)
        self.addSubview(isDoneButton)

        //Поле для ввода имени
        var attributedName = AttributedString("")
        attributedName.font = UIFont.systemFont(ofSize: 18)
        nameField.attributedText = NSAttributedString(attributedName)
        nameField.placeholder = "Задание..."
        nameField.delegate = self
        nameField.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(15)
            maker.leading.equalToSuperview().inset(20)
            maker.trailing.equalTo(isDoneButton.snp.leading).offset(-10)
        }
        
        //Поле описания
        descriptionField.placeholder = "Описание..."
        descriptionField.textColor = .secondaryLabel
        descriptionField.font = UIFont(name: "Bajazzo-NrXlt", size: 14)
        descriptionField.delegate = self
        descriptionField.snp.makeConstraints { maker in
            maker.top.equalTo(nameField.snp.bottom)
            maker.leading.equalTo(nameField.snp.leading)
        }

        //Галочка
        isDoneButton.changesSelectionAsPrimaryAction = true
        isDoneButton.tintColor = .systemBlue
        isDoneButton.configurationUpdateHandler = { button in
            guard var conf = button.configuration else { return }
            let imgConf = UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
            let img = UIImage(systemName: button.isSelected ? "checkmark.circle.fill" : "circle")?.withTintColor(.systemBlue).withConfiguration(imgConf)
            conf.image = img
            
            var backConf = conf.background
            backConf.backgroundColor = .clear
            conf.background = backConf
            
            button.configuration = conf
        }
        isDoneButton.snp.makeConstraints { maker in
            maker.top.trailing.equalToSuperview().inset(20)
            maker.height.equalToSuperview().multipliedBy(0.3)
            maker.width.equalTo(isDoneButton.snp.height)
        }
        isDoneButton.addAction(UIAction(handler: {[unowned self] _ in
            var attributedName = AttributedString(nameField.attributedText!)
            attributedName.strikethroughStyle = isDoneButton.isSelected ? NSUnderlineStyle.single : nil
            nameField.attributedText = NSAttributedString(attributedName)
            item?.isDone = isDoneButton.isSelected
        
            CDManager.saveContext()
        }), for: .touchUpInside)
        
        //Разделитель
        let separator = SeparatorView()
        separator.backgroundColor = .clear
        separator.tintColor = .secondarySystemFill
        self.addSubview(separator)
        separator.snp.makeConstraints { maker in
            maker.top.equalTo(descriptionField.snp.bottom).offset(10)
            maker.leading.trailing.equalToSuperview().inset(30)
            maker.height.equalTo(separator.lineWidth)
        }
        
        //Даты
        self.addSubview(datesView)
        datesView.delegate = self
        datesView.snp.makeConstraints { maker in
            maker.top.equalTo(separator.snp.bottom)
            maker.leading.trailing.equalToSuperview().inset(20)
            maker.bottom.equalToSuperview().inset(5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Delegates and saving
    //Text
    func textFieldDidEndEditing(_ textField: UITextField) {
        item?.name = nameField.text
        item?.desription = descriptionField.text
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        CDManager.saveContext()
        return true
    }
    //Time
    func cellDatesView(withStartDate date: Date) {
        item?.startDate = date
        CDManager.saveContext()
    }
    func cellDatesView(withEndDate date: Date) {
        item?.endDate = date
        CDManager.saveContext()
    }
}

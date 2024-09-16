//
//  TaskCellContentView.swift
//  ToDo
//
//  Created by Данила Бондарь on 16.09.2024.
//

import Foundation
import UIKit
import SnapKit

class TaskCellContentView: UIView, UIContentView{
    
    var configuration: any UIContentConfiguration
    var nameField = UITextField()
    var descriptionField = UITextField()
    var isDoneButton = UIButton(configuration: .plain())
    
    //MARK: - Initialize
    init(configuration conf: TaskCellConfiguration) {
        self.configuration = conf
        super.init(frame: .zero)
        
        createViews()
    }
    
    func createViews(){
        
        let conf = configuration as! TaskCellConfiguration
        
        self.addSubview(nameField)
        self.addSubview(descriptionField)
        self.addSubview(isDoneButton)

        //Поле для ввода имени
        var attributedName = AttributedString(conf.name)
        attributedName.font = UIFont.systemFont(ofSize: 18)
        attributedName.strikethroughStyle = conf.isDone ? NSUnderlineStyle.single : nil
        nameField.attributedText = NSAttributedString(attributedName)
        nameField.placeholder = "Задание..."
        nameField.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(15)
            maker.leading.equalToSuperview().inset(20)
            maker.trailing.equalTo(isDoneButton.snp.leading).offset(-10)
        }
        
        //Поле описания
        descriptionField.placeholder = "Описание..."
        descriptionField.text = conf.description
        descriptionField.textColor = .secondaryLabel
        descriptionField.font = UIFont(name: "Bajazzo-NrXlt", size: 14)
        descriptionField.snp.makeConstraints { maker in
            maker.top.equalTo(nameField.snp.bottom)
            maker.leading.equalTo(nameField.snp.leading)
        }

        //Галочка
        isDoneButton.changesSelectionAsPrimaryAction = true
        isDoneButton.tintColor = .systemBlue
        isDoneButton.isSelected = conf.isDone
        isDoneButton.configurationUpdateHandler = { button in
            var conf = button.configuration
            var imgConf = UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
            let img = UIImage(systemName: button.isSelected ? "checkmark.circle.fill" : "circle")?.withTintColor(.systemBlue).withConfiguration(imgConf)
            conf?.image = img
            conf?.baseBackgroundColor = .clear
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

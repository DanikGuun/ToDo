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
        
        self.addSubview(nameField)
        nameField.text = conf.name
        nameField.placeholder = "Задание..."
        nameField.font = UIFont(name: "Bajazzo-Nr", size: 20)
        nameField.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(15)
            maker.leading.equalToSuperview().inset(20)
            maker.width.equalToSuperview().multipliedBy(0.9)
        }
        
        self.addSubview(descriptionField)
        descriptionField.placeholder = "Описание"
        descriptionField.text = conf.description
        descriptionField.textColor = .secondaryLabel
        descriptionField.font = UIFont(name: "Bajazzo-NrXlt", size: 14)
        descriptionField.snp.makeConstraints { maker in
            maker.top.equalTo(nameField.snp.bottom)
            maker.leading.equalTo(nameField.snp.leading)
        }
        
        self.addSubview(isDoneButton)
        isDoneButton.changesSelectionAsPrimaryAction = true
        isDoneButton.tintColor = .systemBlue
        isDoneButton.configurationUpdateHandler = { button in
            var conf = button.configuration
            var imgConf = UIImage.SymbolConfiguration(weight: .semibold)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

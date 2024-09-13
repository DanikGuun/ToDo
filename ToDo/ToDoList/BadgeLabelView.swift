//
//  BadgeLabelView.swift
//  ToDo
//
//  Created by Данила Бондарь on 13.09.2024.
//

import Foundation
import UIKit

class BadgeLabelView: UIControl{
    
    var labelText: String?{
        get{
            return label.text
        }
        set{
            label.text = newValue
            self.setNeedsDisplay()
        }
    }
    var badgeCount: Int{
        get{
            guard let count = Int(badgeLabel.text ?? " ") else { return 0 }
            return count
        }
        set{
            badgeLabel.text = newValue.description
            self.setNeedsDisplay()
        }
    }
    var selectedColor: UIColor = UIColor.systemBlue { didSet { self.tintColorDidChange() } }
    var unselectedColor: UIColor = UIColor.systemGray { didSet { self.tintColorDidChange() } }
    override var isSelected: Bool { didSet { updateAppereance() } }
    
    private let label = UILabel()
    private let badgeLabel = UILabel()
    
    
    //MARK: - Initialize
    convenience init(){
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup(){
        self.backgroundColor = .clear
        
        self.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.textAlignment = .center
        label.snp.makeConstraints { maker in
            maker.leading.centerY.equalToSuperview()
        }
        
        self.addSubview(badgeLabel)
        badgeLabel.textAlignment = .center
        badgeLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        badgeLabel.textColor = .systemBackground
        badgeLabel.snp.makeConstraints { maker in
            maker.centerY.equalTo(label.snp.centerY)
            maker.leading.equalTo(label.snp.trailing).offset(10)
            maker.width.greaterThanOrEqualTo(badgeLabel.snp.height)
        }
        self.addAction(UIAction(handler: pressed(_:)), for: .touchUpInside)
        
        self.tintColor = unselectedColor
    }
    
    //MARK: - Selection Handler
    
    private func pressed(_ action: UIAction? = nil){
        self.isSelected.toggle()
        updateAppereance()
    }
    
    private func updateAppereance(){
        self.tintColor = self.isSelected ? selectedColor : unselectedColor
        self.label.font = UIFont.systemFont(ofSize: self.label.font.pointSize, weight: self.isSelected ? .regular : .light)
    }
    
    //MARK: - Graphics
    
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        self.setNeedsDisplay()
        self.label.textColor = self.tintColor
    }
    
    override func draw(_ rect: CGRect) {
        self.tintColor.setFill()
        var textExpandedFrame = badgeLabel.frame
        textExpandedFrame.size = CGSize(width: badgeLabel.frame.width + 8, height: badgeLabel.frame.height + 4)
        textExpandedFrame.origin = CGPoint(x: badgeLabel.frame.origin.x - 4, y: badgeLabel.frame.origin.y - 2)
        let path = UIBezierPath(roundedRect: textExpandedFrame, cornerRadius: 10)
        path.fill()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setNeedsDisplay()
    }
}

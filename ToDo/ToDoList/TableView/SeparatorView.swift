//
//  SeparatorView.swift
//  ToDo
//
//  Created by Данила Бондарь on 16.09.2024.
//

import Foundation
import UIKit

class SeparatorView: UIView{
    
    var lineWidth: CGFloat = 1 { didSet { self.setNeedsDisplay() } }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        tintColor.setFill()
        tintColor.setStroke()
        let path = UIBezierPath()

        path.lineWidth = lineWidth
        
        path.move(to: CGPoint(x: lineWidth/2, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.width - lineWidth/2, y: rect.midY))
        path.stroke()
        
        path.addArc(withCenter: CGPoint(x: lineWidth/2, y: rect.midY), radius: lineWidth/2, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        path.addArc(withCenter: CGPoint(x: rect.width - lineWidth/2, y: rect.midY), radius: lineWidth/2, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        path.fill()
        

    }
}

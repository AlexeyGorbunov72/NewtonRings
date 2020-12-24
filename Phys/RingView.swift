//
//  RingView.swift
//  Phys
//
//  Created by Alexey on 07.12.2020.
//

import Foundation
import UIKit
class RingView: UIView{
    var image: UIImage?
    var R: Double = 10000000 {
        didSet{
            layer.sublayers?.forEach{
                $0.removeFromSuperlayer()
            }
            draw(.zero)
        }
    }
    var L: Double = 1488{
        didSet{
            layer.sublayers?.forEach{
                $0.removeFromSuperlayer()
            }
            draw(.zero)
        }
    }
    func findRadius(m: Int) -> (raduis: CGFloat, width: CGFloat){
        let radius = CGFloat(sqrt((Double(m) - 0.5) * L * R) / 100_0)
        let width = dark(m: m) - radius
        return (radius, width)
    }
    func dark(m: Int) -> CGFloat{
        
        return CGFloat(sqrt(Double(m) * L * R) / 100_0)
    }
    override func draw(_ rect: CGRect) {
        layer.masksToBounds = true
        for i in 1...100 where i % 2 == 1{
            let (radius, width) = findRadius(m: i)
            drawCircle(radius: radius, width: width)
        }
        
    }
    func drawCircle(radius: CGFloat, width: CGFloat){
        let path = UIBezierPath(ovalIn: CGRect(x: bounds.midX - radius, y: bounds.midY - radius, width: 2*radius, height: 2*radius))
        let layer_ = CAShapeLayer()
        layer_.path = path.cgPath
        layer_.strokeColor = UIColor(red: 254/255, green: 211/255, blue: 25/255, alpha: 100/radius).cgColor
        layer_.lineWidth = width
        layer_.fillColor = UIColor.clear.cgColor
        layer.addSublayer(layer_)

    }
    func getImage() -> UIImage?{
        UIGraphicsBeginImageContext(bounds.size)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

//
//  QRCreator.swift
//  NativeQR
//
//  Created by Harvey on 2017/10/24.
//  Copyright © 2017年 Harvey. All rights reserved.
//

import Foundation
import CoreImage
import UIKit

class QRCreateModel {
    
    var text: String!
    var logo: String?           // imageName
    var scale: Float = 10
    var backgroundColor: UIColor?
    var contentColor: UIColor?
}

class QRCreator {
    
    static let shared = QRCreator()
    
    private let qrFilter: CIFilter
    private let colorFilter: CIFilter
    
    private init() {
        
        qrFilter = CIFilter(name: "CIQRCodeGenerator")!
        colorFilter = CIFilter(name: "CIFalseColor")!
    }
    
    private func createBase(text: String, scale: Float) -> CIImage? {
        
        qrFilter.setDefaults()
        guard let data = text.data(using: String.Encoding.utf8) else {
            
            return nil
        }
        
        qrFilter.setValue(data, forKey: "inputMessage")
        guard var outputImage = qrFilter.outputImage else {
            
            return nil
        }
        
        outputImage = outputImage.transformed(by: CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale)))
        return outputImage
    }
    
    private func colourFilter(ciImage: CIImage, model: QRCreateModel) -> CIImage? {
        
        colorFilter.setDefaults()
        colorFilter.setValue(ciImage, forKey: "inputImage")
        
        if let _ = model.backgroundColor {
            
            colorFilter.setValue(model.backgroundColor!.ciColor, forKey: "inputColor0")
        }
        
        if let _ = model.contentColor {
            
            colorFilter.setValue(model.contentColor!.ciColor, forKey: "inputColor1")
        }
        
        return colorFilter.outputImage
    }
    
    private func addLogo(ciImage: CIImage, model: QRCreateModel) -> UIImage? {
        
        guard let logoImage = UIImage(named: "logo") else {
            
            return nil
        }
        
        let image = UIImage(ciImage: ciImage)
        
        UIGraphicsBeginImageContext(image.size)
        logoImage.draw(in: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        
        let outPutImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return outPutImage
    }
    
    func create(_ model: QRCreateModel) -> UIImage? {
        
        guard let outputImage = createBase(text: model.text, scale: model.scale) else {
            
            return nil
        }
        
        return UIImage(ciImage: outputImage)
    }
    
    
}

//
//  QRCreateViewController.swift
//  NativeQR
//
//  Created by Harvey on 2017/10/24.
//  Copyright © 2017年 Harvey. All rights reserved.
//

import Foundation
import UIKit

class QRCreateViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.title = "生成二维码"
        
        let qrModel = QRCreateModel()
        qrModel.text = "http://m.hao123.com"
        
        if let qrImage = QRCreator.shared.create(qrModel) {
            
            print(qrImage.size.width)
            print(qrImage.size.height)
            
            imageView.image = qrImage
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
}

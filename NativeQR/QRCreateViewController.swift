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
        qrModel.text = "https://www.yaozuopan.top"
        qrModel.contentColor = UIColor.yellow
        qrModel.backgroundColor = UIColor.gray
        
        /// 二维码的容错率最大为30%(即二维码被遮挡的部分不能大于30%,否则二维码无法被识别)
        /// e.g.
        /// 假设二维码大小为{100,100}, logo的大小最大为{30,30}
        /// 在设置loog请注意
        // qrModel.logo = "mylogo"
        
        if let qrImage = QRCreator.shared.create(qrModel) {
            
            print(qrImage.size.width)
            print(qrImage.size.height)
            // imageView.image = qrImage
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
}

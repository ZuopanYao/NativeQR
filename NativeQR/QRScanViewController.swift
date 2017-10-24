//
//  QRScanViewController.swift
//  NativeQR
//
//  Created by Harvey on 2017/10/24.
//  Copyright © 2017年 Harvey. All rights reserved.
//

import Foundation
import UIKit

class QRScanViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.title = "扫一扫"
        
        QRScanner.shared
        .scan { (previewLayer) in
            
            let width = UIScreen.main.bounds.size.width - 100
            previewLayer.frame = CGRect(x: 50, y: 100, width: width, height: width)
            self.view.layer.insertSublayer(previewLayer, at: 0)
        }
        .completed { (qrValue) in
            
             print(qrValue)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        QRScanner.shared.stopRunning()
    }
}

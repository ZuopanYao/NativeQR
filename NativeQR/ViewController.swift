//
//  ViewController.swift
//  NativeQR
//
//  Created by Harvey on 2017/10/24.
//  Copyright © 2017年 Harvey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func scanQR(sender: UIButton) {
        
        guard let instanceVC = storyboard?.instantiateViewController(withIdentifier: "QRScanViewController") else {
            return
        }
        
        navigationController?.pushViewController(instanceVC, animated: true)
    }
    
    @IBAction func createQR(sender: UIButton) {
        
        guard let instanceVC = storyboard?.instantiateViewController(withIdentifier: "QRCreateViewController") else {
            return
        }
        
        navigationController?.pushViewController(instanceVC, animated: true)
    }
}


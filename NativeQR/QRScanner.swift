//
//  QRScanner.swift
//  NativeQR
//
//  Created by Harvey on 2017/10/24.
//  Copyright © 2017年 Harvey. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class QRScanner: NSObject {
    
    static let shared = QRScanner()
    
    private let captureSession = AVCaptureSession()
    private let videoPreviewLayer = AVCaptureVideoPreviewLayer()
    
    private var handleCompleted: ((String) -> ())? = nil
    
    private override init() {
        
        super.init()
        
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { (isSuccess) in
        
            if isSuccess {
                
                self.prepare()
            }else {
                
                print("无权访问摄像机")
            }
        }
    }
    
    private func prepare() {
        
        guard let device = AVCaptureDevice.default(for: .video) else {
        
            print("获取摄像设备发生错误")
            return
        }
        
        guard let deviceInput = try? AVCaptureDeviceInput(device: device) else {
            
            print("创建设备输入流发生错误")
            return
        }
        
        // 创建数据输出流
        let metadataOutput = AVCaptureMetadataOutput()
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        // 创建设备输出流
        let videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)
        
        // 会话采集率: AVCaptureSessionPresetHigh
        captureSession.sessionPreset = .high
        
        // 添加数据输出流到会话对象
        captureSession.addOutput(metadataOutput)
        
        // 添加设备输出流到会话对象
        captureSession.addOutput(videoDataOutput)
      
        // 添加设备输入流到会话对象
        captureSession.addInput(deviceInput)
        
        // 设置数据输出类型
        metadataOutput.metadataObjectTypes = [
            .qr,        // 二维码
            .ean13,     // 条形码
            .ean8,      // 条形码
            .code128    // 条形码
        ]
        
        videoPreviewLayer.session = captureSession
        videoPreviewLayer.videoGravity = .resizeAspectFill
    }
    
    func scan(design: @escaping (_ previewLayer: CALayer)->()) -> Self {
        
        design(videoPreviewLayer)
        
        startRunning()
        
        return self
    }
    
    func completed(aCompleted: @escaping (_ value: String)->()) {
        
        self.handleCompleted = aCompleted
    }
    
    func startRunning() {
        
        captureSession.startRunning()
    }
    
    func stopRunning() {
        
        captureSession.stopRunning()
    }
}

extension QRScanner: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        guard metadataObjects.count>0 else{
            
            return
        }
        
        stopRunning()
        
        guard let stringValue = metadataObjects.first!.value(forKey: "stringValue") as? String else {
            
            return
        }
        
        handleCompleted?(stringValue)
    }
}

extension QRScanner: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
    }
}

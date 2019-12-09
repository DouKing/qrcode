//
// qrcode
// Brain.swift
//
// Created by wuyikai on 2019/12/7.
// Copyright © 2019 wuyikai. All rights reserved.
// 

import SwiftUI

extension Image {
    static func qrImage(with content: String) -> Image {
        return Image(nsImage: content.toQR() ?? NSImage())
    }
}

extension String {
    func toQR() -> NSImage? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else {
            return nil
        }
        
        qrFilter.setValue(data, forKey: "inputMessage")
        qrFilter.setValue("L", forKey: "inputCorrectionLevel")
        
        guard let outputImage = qrFilter.outputImage,
            let inputColor0 = CIColor(color: .black),
            let inputColor1 = CIColor(color: .white)
            else { return nil }
        
        guard let colorFilter = CIFilter(name: "CIFalseColor", parameters: [
            "inputImage": outputImage,
            "inputColor0": inputColor0,
            "inputColor1": inputColor1,
        ]) else {
            return nil
        }
        let size = NSSize(width: 200, height: 200)
        guard let qrImage = colorFilter.outputImage?.transformed(by: CGAffineTransform(scaleX: size.width/outputImage.extent.width, y: size.height/outputImage.extent.height)) else { return nil }
        guard let cgImage = CIContext().createCGImage(qrImage, from: qrImage.extent) else { return nil }
        
        return NSImage(cgImage: cgImage, size: size)
    }
}

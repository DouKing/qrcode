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
//        return Image(nsImage: content.toQR() ?? NSImage())
        
//        let data = content.data(using: .utf8)!
//        let aztecBarCode = AztecBarcode(inputMessage: data)
//        let nsimage = BarcodeService.generateBarcode(from: aztecBarCode)!.toNSImage(scalar: 1) ?? NSImage()

        let data = content.data(using: .utf8)!
        let qrCode = QRCode(inputMessage: data)
        let nsimage = BarcodeService.generateBarcode(from: qrCode)!.toNSImage(scalar: 2.5) ?? NSImage()
        
//        let pdfBarCode = PDF417Barcode(
//            inputMessage: content.data(using: .ascii)!,
//            inputMinWidth: 100,
//            inputMaxWidth: 100,
//            inputMinHeight: 100,
//            inputMaxHeight: 100,
//            inputDataColumns: 10,
//            inputRows: 10,
//            inputPreferredAspectRatio: 3,
//            inputCompactionMode: 2,
//            inputCompactStyle: true,
//            inputCorrectionLevel: 2,
//            inputAlwaysSpecifyCompaction: true
//        )
//        let nsimage = BarcodeService.generateBarcode(from: pdfBarCode)!.toNSImage(scalar: 1) ?? NSImage()
        
//        let code128BarCode = Code128Barcode(
//            inputMessage: content.data(using: .ascii)!,
//            inputQuietSpace: 1,
//            inputBarcodeHeight: 50
//        )
//        let nsimage = BarcodeService.generateBarcode(from: code128BarCode)!.toNSImage(scalar: 1) ?? NSImage()

        return Image(nsImage: nsimage)
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
        let transform = CGAffineTransform(scaleX: 8.0, y: 8.0)
        let size = NSSize(width: outputImage.extent.width * 8, height: outputImage.extent.height * 8)
        guard let qrImage = colorFilter.outputImage?.transformed(by: transform) else { return nil }
        guard let cgImage = CIContext().createCGImage(qrImage, from: qrImage.extent) else { return nil }
        
        return NSImage(cgImage: cgImage, size: size)
    }
}

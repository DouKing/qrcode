//
// qrcode
// CIImage+Extension.swift
//
// Created by wuyikai on 2022/4/14.
// Copyright © 2022 wuyikai. All rights reserved.
// 

import CoreImage
import AppKit

extension CIImage {
    func toNSImage(scalar: CGFloat = 1) -> NSImage? {
        guard let cgImage = CIContext().createCGImage(self, from: self.extent) else {
            return nil
        }
        let size = NSSize(width: self.extent.width * scalar,
                          height: self.extent.height * scalar)
        return NSImage(cgImage: cgImage, size: size)
    }
}

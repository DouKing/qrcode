//
// qrcode
// ContentView.swift
//
// Created by wuyikai on 2019/11/24.
// Copyright © 2019 wuyikai. All rights reserved.
// 

import SwiftUI
import CoreGraphics

struct ContentView: View {
  @State var input: String = ""
  @State var image: NSImage = NSImage()
  
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 5) {
        Image.qrImage(with: self.input)
          .aspectRatio(contentMode: .fit)
          .frame(width: 200, height: 200, alignment: .center)
      }.frame(minHeight: 300, alignment: .center)
      
      VStack(alignment: .leading) {
        Text(self.input)
          .foregroundColor(Color.gray)
          .multilineTextAlignment(.leading)
        
        TextField("placeholder", text: $input)
          .font(.title)
          .frame(minWidth: 500, minHeight: 44)
        
        HStack {
          Button("清除") {
            self.input = ""
          }
          .frame(width: 80, height: 44, alignment: .leading)
        }
      }
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

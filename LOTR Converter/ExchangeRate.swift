//
//  ExchangeRate.swift
//  LOTR Converter
//
//  Created by Samir Ramic on 22.09.25.
//

import Foundation
import SwiftUI


struct ExchangeRate: View {
    
    let leftImage: ImageResource
    let rightImage: ImageResource
    let text: String
    
    init(
        leftImage: ImageResource = .goldpiece,
        rightImage: ImageResource = .goldpenny,
        text: String = "1 Gold Piece = 4 Gold Pennies"
    ) {
        self.leftImage = leftImage
        self.rightImage = rightImage
        self.text = text
    }
    
    var body: some View {
        HStack {
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
            
            Text(text)
            
            Image(rightImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
        }
    }
}

#Preview {
    ExchangeRate(leftImage: .goldpiece,
                 rightImage: .goldpenny,
                 text: "1 Gold Piece = 4 Gold Pennies")
}

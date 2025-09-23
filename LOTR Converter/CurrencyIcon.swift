//
//  Currency.swift
//  LOTR Converter
//
//  Created by Samir Ramic on 22.09.25.
//

import Foundation
import SwiftUI

struct CurrencyIcon: View {
    var currencyText: String
    var currencyImage: ImageResource
    
    init(currency: String = "Copper Penny", image: ImageResource = .copperpenny) {
        self.currencyText = currency
        self.currencyImage = image
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            Image(currencyImage)
                .resizable()
                .scaledToFit()
            
            Text(currencyText)
                .padding(3)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(.brown.opacity(0.75))
        }
        .padding(3)
        .frame(width: 100, height: 100)
        .background(.brown)
        .clipShape(.rect(cornerRadius: 25))
    }
}

#Preview {
    CurrencyIcon()
}


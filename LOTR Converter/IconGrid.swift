//
//  IconGrid.swift
//  LOTR Converter
//
//  Created by Samir Ramic on 22.09.25.
//

import Foundation
import SwiftUI


struct IconGrid: View {
    let currencies: [Currency] = Currency.allCases
    @Binding var currencyRaw: Double
    
    var currency: Currency {
        get {
            Currency(rawValue: currencyRaw) ?? Currency.bronzePenny
        }
        set {
            currencyRaw = Double(newValue.rawValue)
        }
    }

    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]){
            ForEach(currencies, id: \.self) { currency in
                CurrencyIcon(
                    currency: currency.name,
                    image: currency.image).background(RoundedRectangle(cornerRadius: 25)
                    )
                    .shadow(radius: self.currencyRaw == currency.rawValue ? 10 : 0)
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 3).opacity( self.currencyRaw == currency.rawValue ? 0.5: 0.0)
                    )
                    .onTapGesture {
                        self.currencyRaw = currency.rawValue
                    }
            }
        }
    }
}

#Preview {
    @Previewable @State var currency: Double = Currency.goldPiece.rawValue
    IconGrid(currencyRaw: $currency)
}


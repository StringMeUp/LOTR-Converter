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
    @Binding var currency: Currency?

    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]){
            ForEach(currencies, id: \.self) { currency in
                CurrencyIcon(
                    currency: currency.name,
                    image: currency.image).background(RoundedRectangle(cornerRadius: 25)
                    )
                    .shadow(radius: self.currency == currency ? 10 : 0)
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 3).opacity( self.currency == currency ? 0.5: 0.0)
                    )
                    .onTapGesture {
                        self.currency = currency
                    }
            }
        }
    }
}

#Preview {
    @Previewable @State var currency: Currency? = nil
    IconGrid(currency: $currency)
}


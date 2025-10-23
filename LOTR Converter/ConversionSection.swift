//
//  ConversionSection.swift
//  LOTR Converter
//
//  Created by Samir Ramic on 23.10.25.
//

import SwiftUI
import TipKit
import Foundation

struct ConversionSection: View {
    
    @Binding var currencyAmount: Double?
    @Binding var currency: Currency
    @FocusState.Binding var focusField: Field?
    @Binding var showCurrencySheet: Bool
    var field: Field
    
    private let currencyTip = CurrencyTip()

    var body: some View {
            //Currency
            HStack {
                //Currency image
                Image(currency.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height:33)
                
                //Currency Text
                Text(currency.name)
                    .font(.headline)
                    .foregroundStyle(.white)
            }
            .padding(.bottom, -5)
            .onTapGesture {
                showCurrencySheet.toggle()
                currencyTip.invalidate(reason: .actionPerformed)
            }
            .popoverTip(currencyTip, arrowEdge: .bottom)
            
            TextField("Amount", value: $currencyAmount, format: .number)
                .focused($focusField, equals: field)
                .textFieldStyle(.roundedBorder)
    }
}


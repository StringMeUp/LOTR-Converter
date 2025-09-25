//
//  SelectCurrency.swift
//  LOTR Converter
//
//  Created by Samir Ramic on 22.09.25.
//

import Foundation
import SwiftUI


struct SelectCurrency: View {

    @Environment(\.dismiss) var dismiss
    
    let currencies: [Currency] = Currency.allCases
    
    @Binding var fromCurrencyRaw: Double
    @Binding var toCurrencyRaw: Double
    
    var fromCurrency: Currency {
        get {Currency(rawValue: fromCurrencyRaw) ?? Currency.goldPenny}
        set {fromCurrencyRaw = newValue.rawValue}
    }
    
    var body: some View {
        ZStack{
            //Background image
            Image(.parchment)
                .resizable()
                .ignoresSafeArea(.all)
                .background(.brown)
            
            VStack(alignment: .leading, spacing: 20){
                Text("Select the currency you are starting with:")
                IconGrid(currencyRaw: $fromCurrencyRaw)
                
                Text("Select the currency you would like to convert to:")
                IconGrid(currencyRaw: $toCurrencyRaw)
                
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown.mix(with: .black, by: 0.2))
                .font(.largeTitle)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
               
                
            }.padding()
                .fontWeight(.bold)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            
        }
    }
}


#Preview {
    @Previewable @State var fromCurrency: Double = Currency.copperPenny.rawValue
    @Previewable @State var toCurrency: Double = Currency.goldPenny.rawValue
    SelectCurrency(fromCurrencyRaw: $fromCurrency, toCurrencyRaw: $toCurrency)
}


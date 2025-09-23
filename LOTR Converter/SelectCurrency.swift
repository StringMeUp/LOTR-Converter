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
    
    @Binding var fromCurrency: Currency?
    @Binding var toCurrency: Currency?
    
    var body: some View {
        ZStack{
            //Background image
            Image(.parchment)
                .resizable()
                .ignoresSafeArea(.all)
                .background(.brown)
            
            VStack(alignment: .leading, spacing: 20){
                Text("Select the currency you are starting with:")
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]){
                    ForEach(currencies, id: \.self) { currency in
                        CurrencyIcon(
                            currency: currency.name,
                            image: currency.image).background(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(
                                        fromCurrency == currency ?
                                        Color.black : Color.clear, lineWidth: 5)
                                    
                                   
                            )
                            .shadow(radius: fromCurrency == currency ? 10 : 0)
                            .onTapGesture {
                                fromCurrency = currency
                            }
                    }
                }
                
                Text("Select the currency you would like to convert to:")
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]){
                    ForEach(currencies, id: \.self) { currency in
                        CurrencyIcon(currency: currency.name, image:currency.image).background(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(toCurrency == currency ? Color.black : Color.clear, lineWidth: 5)
                        )
                        .shadow(radius: toCurrency == currency ? 10 : 0)
                        .onTapGesture {
                            toCurrency = currency
                        }
                    }
                }
                
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

struct SelectCurrency_PreviewWrapper: View {
    @State private var fromCurrency: Currency? = nil
    @State private var toCurrency: Currency? = nil
    
    var body: some View {
        SelectCurrency(fromCurrency: $fromCurrency, toCurrency: $toCurrency)
    }
}

#Preview {
    SelectCurrency_PreviewWrapper()
}


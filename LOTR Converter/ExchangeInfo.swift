//
//  ExchangeInfo.swift
//  LOTR Converter
//
//  Created by Samir Ramic on 22.09.25.
//

import SwiftUI

struct ExchangeInfo: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        //Background Image
        ZStack {
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack(alignment: HorizontalAlignment.center, spacing: 50.0) {
                //Title Text
                Text("Exchange Rates")
                    .font(.largeTitle)
                    .fontWeight(.regular)
                    .tracking(3)
                    .foregroundColor(.black)
                    .padding()
                
                //Description Text
                Text("Here at the Prancing Pony, we are happy to offer you a place where you can exchange all the known currencies in the entire world except one. We used to take Brandy Bucks, but after finding out that it was a person instead of a piece of paper, we realized it had no value to us. Below is a simple guide to our currency exchange rates:") .font(.title3)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .padding(.bottom)
                
                //4x InfExchange
                VStack{
                    ExchangeRate(
                        leftImage: .goldpiece,
                        rightImage: .goldpenny,
                        text: "1 Gold Piece = 4 Gold Pennies")
                
                    ExchangeRate(
                        leftImage: .goldpenny,
                        rightImage: .silverpiece,
                        text: "1 Gold Penny = 4 Silver Pieces")
                    
                    ExchangeRate(
                        leftImage: .silverpiece,
                        rightImage: .silverpenny,
                        text: "1 Silver Piece = 4 Silver Pennies")
                    
                    ExchangeRate(
                        leftImage: .silverpenny,
                        rightImage: .copperpenny,
                        text: "1 Silver Penny = 100 Copper Pennies")
                    
                }.padding(.bottom)
                
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown.mix(with: .black, by: 0.2))
                .font(.largeTitle)
                .foregroundStyle(.white)
                    
            }.padding()
            .foregroundStyle(.black)
        }
    }
}

#Preview("ExchangeInfo") {
    ExchangeInfo()
}

#Preview("ExchangeRate") {
    ExchangeRate()
}

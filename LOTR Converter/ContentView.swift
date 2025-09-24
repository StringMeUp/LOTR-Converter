//
//  ContentView.swift
//  LOTR Converter
//
//  Created by Samir Ramic on 18.09.25.
//

import SwiftUI

struct ContentView: View {
    //Stored property with @State
    @State private var leftAmount: Double?
    @State private var rightAmount: Double?
    @State private var showExchangeInfo: Bool = false
    @State private var showCurrencySheet: Bool = false
    @State private var leftCurrency: Currency = Currency.goldPiece
    @State private var rightCurrency: Currency = Currency.silverPenny
    
    var body: some View {
        ZStack {
            //Backround image
            Image(.background)
                .resizable()
                .ignoresSafeArea()
        
            VStack {
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                //Currency Text
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                //Conversion Section
                HStack {
                    //Left
                    VStack(alignment: HorizontalAlignment.leading) {
                        //Currency
                        HStack {
                            //Currency image
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height:33)
                            
                            //Currency Text
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }.padding(.bottom, -5).onTapGesture {
                            showCurrencySheet.toggle()
                        }.sheet(isPresented: $showCurrencySheet, content: {
                            SelectCurrency(
                                fromCurrency: $leftCurrency,
                                toCurrency: $rightCurrency
                            )
                        })
                
                        TextField("Amount", value: $leftAmount, format: .number)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    //Equal sign
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
                    
                    //Right
                    VStack(alignment: .trailing) {
                        //Currency
                        HStack {
                            //Currency Text
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            //Currency image
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height:33)
                        }.padding(.bottom, -5).onTapGesture {
                            showCurrencySheet.toggle()
                        }
                        
                        TextField("Amount", value: $rightAmount, format: .number)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                
                    }
                }.padding()
                    .background(.black.opacity(0.5))
                    .clipShape(Capsule())
                Spacer()
                //Info Button
                HStack {
                    Spacer()
                    Button{
                        showExchangeInfo.toggle()
                        print(showExchangeInfo)
                    } label: {
                        Image(systemName: "info.circle.fill")
                        
                    }.font(.largeTitle)
                        .foregroundStyle(.white)
                        .padding(.trailing)
                        
                }.sheet(isPresented: $showExchangeInfo, content: {
                    ExchangeInfo()
                }).sheet(isPresented: $showCurrencySheet, content: {
                    SelectCurrency(
                        fromCurrency: $leftCurrency,
                        toCurrency: $rightCurrency
                    )
                })
          
            }
        }
        .onChange(of: leftAmount) { calculateRightCurrency() }
        .onChange(of: rightAmount) { calculateLeftCurrency() }
        .onChange(of: leftCurrency) { calculateRightCurrency() }
        .onChange(of: rightCurrency) { calculateLeftCurrency() }
    }
    
    func calculateRightCurrency() {
        guard let amount = leftAmount else {
            rightAmount = nil
            return
        }
        
        rightAmount = leftCurrency.convert(amount: amount, to: rightCurrency)
    
    }
    
    func calculateLeftCurrency() {
        guard let amount = rightAmount else {
            leftAmount = nil
            return
        }
        
        leftAmount = rightCurrency.convert(amount: amount, to: leftCurrency)
    }
}

#Preview {
    ContentView()
}

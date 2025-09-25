//
//  ContentView.swift
//  LOTR Converter
//
//  Created by Samir Ramic on 18.09.25.
//

import SwiftUI
import TipKit

struct ContentView: View {

    //Stored property with @State
    @State private var leftAmount: Double?
    @State private var rightAmount: Double?
    @FocusState private var focusField: Field?
    @State private var showExchangeInfo: Bool = false
    @State private var showCurrencySheet: Bool = false
    @State private var leftCurrency: Currency = Currency.goldPiece
    @State private var rightCurrency: Currency = Currency.silverPenny
    private let currencyTip = CurrencyTip()

    
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
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showCurrencySheet.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }
                        .popoverTip(currencyTip, arrowEdge: .bottom)
                        
                        TextField("Amount", value: $leftAmount, format: .number)
                            .focused($focusField, equals: .leftInput)
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
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showCurrencySheet.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }
                        .popoverTip(currencyTip, arrowEdge: .bottom)
                        
                        TextField("Amount", value: $rightAmount, format: .number)
                            .focused($focusField, equals: .rightInput)
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
                    
                }
                
            }.keyboardType(.decimalPad)
        }
        .task {
            try? Tips.configure()
        }
        .onChange(of: leftAmount) {
            if focusField == .leftInput {
                convertToRight()
            }
        }
        .onChange(of: rightAmount) {
            if focusField == .rightInput {
                convertToLeft()
            }
        }
        .onChange(of: leftCurrency) { convertToRight() }
        .onChange(of: rightCurrency) { convertToLeft() }
        .sheet(isPresented: $showExchangeInfo, content: {
            ExchangeInfo() })
        .sheet(isPresented: $showCurrencySheet, content: {
            SelectCurrency(
                fromCurrency: $leftCurrency,
                toCurrency: $rightCurrency
            )
        }).onTapGesture {
            focusField = nil
        }
    }
    
    func convertToRight() {
        rightAmount = leftCurrency.convert(amount: leftAmount, to: rightCurrency)
        
    }
    
    func convertToLeft() {
        leftAmount = rightCurrency.convert(amount: rightAmount, to: leftCurrency)
    }
}

#Preview {
    ContentView()
}

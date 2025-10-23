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
    @AppStorage("leftCurrency") private var leftCurrencyRaw: Double = Currency.goldPiece.rawValue
    @AppStorage("rightCurrency") private var rightCurrencyRaw: Double = Currency.silverPiece.rawValue
    
    var leftCurrency: Currency {
        get { Currency(rawValue: leftCurrencyRaw) ?? .goldPiece }
        set { leftCurrencyRaw = newValue.rawValue }
    }
    
    var rightCurrency: Currency {
        get { Currency(rawValue: rightCurrencyRaw) ?? .silverPiece }
        set { rightCurrencyRaw = newValue.rawValue }
    }
    
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
                        ConversionSection(
                            currencyAmount: $leftAmount  ,
                            currency: Binding(
                                get: { leftCurrency },
                                set: { leftCurrencyRaw = $0.rawValue }
                            ),
                            focusField: $focusField,
                            showCurrencySheet: $showCurrencySheet,
                            field: Field.leftInput
                        )
                    }
                    
                    //Equal sign
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
                    
                    //Right
                    VStack(alignment: HorizontalAlignment.trailing) {
                        ConversionSection(
                            currencyAmount: $rightAmount,
                            currency: Binding(
                                get: { rightCurrency },
                                set: { rightCurrencyRaw = $0.rawValue }
                            ),
                            focusField: $focusField,
                            showCurrencySheet: $showCurrencySheet,
                            field: Field.rightInput
                        )
                    }
                }
                .padding()
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
                fromCurrencyRaw: $leftCurrencyRaw,
                toCurrencyRaw: $rightCurrencyRaw
            )
        }).onTapGesture {
            focusField = nil
        }
    }
    
    func convertToRight() {
        rightAmount = leftCurrency
            .convert(amount: leftAmount, to:  rightCurrency)
        
    }
    
    func convertToLeft() {
        leftAmount = rightCurrency
            .convert(amount: rightAmount, to: leftCurrency)
    }
}

#Preview {
    ContentView()
}

//
//  CurrencyTip.swift
//  LOTR Converter
//
//  Created by Samir Ramic on 25.09.25.
//

import Foundation
import SwiftUI
import TipKit

struct CurrencyTip: Tip {
    var title: Text = Text("Change Currency")
    var message: Text? = Text("You can tap the left or the right currency to bring up the Select Currency screen.")
}

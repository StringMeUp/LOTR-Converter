//
//  Currency.swift
//  LOTR Converter
//
//  Created by Samir Ramic on 23.09.25.
//

import Foundation
import SwiftUI

enum Currency: Double, CaseIterable, Identifiable {
    
    case copperPenny = 6400
    case silverPenny = 64
    case silverPiece = 16
    case goldPenny = 4
    case goldPiece = 1
    
    var id: Currency { self }
    
    var image: ImageResource {
        switch self {
        case .copperPenny:
            return .copperpenny
        case .silverPenny:
            return .silverpenny
        case .silverPiece:
            return .silverpiece
        case .goldPenny:
            return.goldpenny
        default :
            return .goldpiece
        }
    }
    
    var name : String {
        switch self {
        case .copperPenny:
            return "Copper Penny"
        case .silverPenny:
            return "Silver Penny"
        case .silverPiece:
            return "Silver Piece"
        case .goldPenny:
            return "Gold Penny"
        default:
            return "Gold Piece"
        }
    }
    
    func convert(amount: Double, to target: Currency) -> Double {
        amount * (target.rawValue / self.rawValue)
    }
}

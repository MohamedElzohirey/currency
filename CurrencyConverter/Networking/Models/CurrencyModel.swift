//
//  CurrencyModel.swift
//  CurrencyConverter
//
//  Created by Mohamed Elzohirey on 31/07/2021.
//

import Foundation

struct Currency{
    let name:String
    let ratio:Double
}

struct RatesResponseModel: Codable {
    let success: Bool
    let rates: [String: Double]
    let timestamp: Int
    let base, date: String
}

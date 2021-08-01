//
//  CurrencyService.swift
//  CurrencyConverter
//
//  Created by Mohamed Elzohirey on 31/07/2021.
//

import Moya
////////////////////////////////////////////////////////////////////////////
enum CurrencyService {
    case fetchAllCurrencies(baseCurrencyCode: String, loader: Bool = true)
}
////////////////////////////////////////////////////////////////////////////
extension CurrencyService: ConfiguredMoyaTarget {
    var method: Moya.Method {
        switch self {
        case .fetchAllCurrencies:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .fetchAllCurrencies:
            return ""
        }
    }
    
    var task: Task {
        switch self {
        case .fetchAllCurrencies(let currency, _):
            return .requestParameters(
                parameters:  ["cbase": currency], encoding: URLEncoding.queryString)

        }
    }
    
    var needLoader: Bool {
        switch self {
        case .fetchAllCurrencies(_ , let loader):
            return loader
        }
    }
}
////////////////////////////////////////////////////////////////////////////


//
//  AlamofireNetworkLogger.swift
//  CurrencyConverter
//
//  Created by Mohamed Elzohirey on 31/07/2021.
//

import Alamofire
import Foundation

final class AlamofireNetworkLogger: EventMonitor {
    func requestDidResume(_ request: Request) {
        logDivider()
        let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
        let message = """
        ⚡️ Request Started: \(request)
        ⚡️ Body Data: \(body)
        """
        #if DEBUG
            print(message)
        #else
            print("""
            ⚡️ Request requestDidResume
            """)
        #endif
        logDivider()
    }
    
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        logDivider()
        #if DEBUG
            print("⚡️ Response Received: \(response.debugDescription)")
        #else
            print("""
            ⚡️ Request didParseResponse data
            """)
        #endif
        logDivider()
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        logDivider()
        #if DEBUG
            print("⚡️ Response Received: \(response.debugDescription)")
        #else
            print("""
            ⚡️ Request didParseResponse values
            """)
        #endif
        logDivider()
    }
}
////////////////////////////////////////////////////////////////////////////
private extension AlamofireNetworkLogger {
    func logDivider() {
        print("////////////////////////////////////////////////////////////////////////////")
    }
}
////////////////////////////////////////////////////////////////////////////


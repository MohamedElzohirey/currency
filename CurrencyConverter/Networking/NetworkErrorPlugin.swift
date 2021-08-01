//
//  NetworkErrorPlugin.swift
//  CurrencyConverter
//
//  Created by Mohamed Elzohirey on 31/07/2021.
//

import Moya
public final class NetworkErrorPlugin: PluginType {

    public typealias NetworkErrorClosure = (_ error: MoyaError, _ target: TargetType) -> Void
    let networkErrorClosure: NetworkErrorClosure

    /// Initializes a NetworkActivityPlugin.
    public init(networkErrorClosure: @escaping NetworkErrorClosure) {
        self.networkErrorClosure = networkErrorClosure
    }

    // MARK: Plugin
    /// Called by the provider as soon as a response arrives, even if the request is canceled.
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        switch result {
        case let .success(response): if (400..<500).contains(response.statusCode){
            //create
            let error = MoyaError.statusCode(response)
            networkErrorClosure(error, target)
        }
        case let .failure(error):
            networkErrorClosure(error, target)
        }
    }
}


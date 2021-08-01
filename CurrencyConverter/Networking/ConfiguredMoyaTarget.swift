//
//  ConfiguredMoyaTarget.swift
//  CurrencyConverter
//
//  Created by Mohamed Elzohirey on 31/07/2021.
//

import Alamofire
import Moya
////////////////////////////////////////////////////////////////////////////
struct Networking {
    #if ENVSANDBOXANALYTICS || DEBUG
        static let baseURL = "http://data.fixer.io"
        static let fixerKey = "e32d14bd120f07c935fcbcec75fceced"
    #else
        static let baseURL = "http://data.fixer.io"
        static let fixerKey = "e32d14bd120f07c935fcbcec75fceced"
    #endif
    
    static func getConfiguredMoyaProviderWith<TargetType>(vc: BaseVC?) -> MoyaProvider<TargetType> {
        weak var vc = vc
        var plugins: [PluginType] = []
        
        #if DEBUG
            plugins.append(NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter), logOptions: .verbose)))
        #endif
                
        plugins.append(AccessTokenPlugin(tokenClosure: { (type) -> String in
            return currentToken()
        }))

        plugins.append(NetworkActivityPlugin(networkActivityClosure: { (change, type) in
            if let configured = (type as? ConfiguredMoyaTarget), configured.needLoader {
                DispatchQueue.main.async {
                    if change == .began {
                        vc?.loaderIndicatorHidden.accept(false)
                    }
                    else {
                        vc?.loaderIndicatorHidden.accept(true)
                    }
                }
            }
        }))

        plugins.append(NetworkErrorPlugin(networkErrorClosure: { (error, type) in
            if let configured = (type as? ConfiguredMoyaTarget), configured.shouldHandleError {
            }
        }))

        //bybass https certificate
        let session:Session = .init(interceptor: AuthManager.shared, serverTrustManager: ServerTrustManager(evaluators: ["data.fixer.io": DisabledTrustEvaluator()]))

        return MoyaProvider(session: session, plugins: plugins)
    }

    static func currentToken() -> String {
        if let userDefaults = UserDefaults(suiteName: "com.swensonhe.CurrencyConverter") {
            if let value1 = userDefaults.string(forKey: Key.accessToken){
                return value1
            }
        }
        return UserDefaults.standard.string(forKey: Key.accessToken) ?? ""
    }
    
    static func currentTokenType() -> String {
        if let userDefaults = UserDefaults(suiteName: "com.swensonhe.CurrencyConverter") {
            if let value1 = userDefaults.string(forKey: Key.accessTokenType){
                return value1
            }
        }
        return UserDefaults.standard.string(forKey: Key.accessTokenType) ?? ""
    }

    static func setToken(_ token: String) {
        if let userDefaults = UserDefaults(suiteName: "com.swensonhe.CurrencyConverter") {
            userDefaults.set(token , forKey: Key.accessToken)
            userDefaults.synchronize()
        }
        UserDefaults.standard.set(token, forKey: Key.accessToken)
        UserDefaults.standard.synchronize()

    }

    static func setTokenType(_ tokenType: String) {
        if let userDefaults = UserDefaults(suiteName: "com.swensonhe.CurrencyConverter") {
            userDefaults.set(tokenType , forKey: Key.accessTokenType)
            userDefaults.synchronize()
        }
        UserDefaults.standard.set(tokenType, forKey: Key.accessTokenType)
        UserDefaults.standard.synchronize()
    }
    
    struct Key {
        static let accessToken = "access-token"
        static let accessTokenType = "access-token-type"
    }
}
////////////////////////////////////////////////////////////////////////////
public protocol ConfiguredMoyaTarget: TargetType, AccessTokenAuthorizable {
    var needLoader: Bool { get }
    var shouldHandleError: Bool { get }
    var needErrorPopUp: Bool { get }
}
////////////////////////////////////////////////////////////////////////////
public typealias RequestRetryHandler = () -> Void
////////////////////////////////////////////////////////////////////////////
extension ConfiguredMoyaTarget {
    var shouldLogError: Bool? {
        true
    }
    var baseURL: URL {
        return URL(string: (Networking.baseURL) +  "/api/latest?access_key=\(Networking.fixerKey)")!
    }
    var sampleData: Data {
        return Data()
    }
    var headers: [String : String]? {
        var allHeaders:[String:String] = [:]
        allHeaders["Accept"] = "application/json"
        return allHeaders
    }
    var needLoader: Bool {
        return true
    }
    var authorizationType: AuthorizationType? {
        guard Networking.currentToken().count > 0 else {
            return .none
        }
        return .custom(Networking.currentTokenType())
    }
    var shouldHandleError: Bool {
        return true
    }
    var needErrorPopUp: Bool {
        return true
    }
}
////////////////////////////////////////////////////////////////////////////
private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}
////////////////////////////////////////////////////////////////////////////

class AuthManager: RequestInterceptor {
    static let shared  = AuthManager()

    private init() {
    }
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            /// The request did not fail due to a 401 Unauthorized response.
            /// Return the original error and don't retry the request.
            return completion(.doNotRetryWithError(error))
        }
    }
}

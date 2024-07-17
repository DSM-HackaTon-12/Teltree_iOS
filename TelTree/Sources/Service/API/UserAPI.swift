import Foundation
import UIKit
import Moya

enum UserAPI {
    case login(email: String, password: String)
    case signup(username: String, password: String, email: String)
}

extension UserAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://13.125.214.128:3000")!
    }

    var path: String {
        switch self {
        case .login:
            return "/user/login"
        case .signup:
            return "/user/signup"
        }
    }

    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .signup:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
            
        case let .login(email, password):
            return .requestParameters(
                parameters: [
                    "email": email,
                    "password": password
                ],
                encoding: JSONEncoding.default
            )
        case let .signup(username, password, email):
            return .requestParameters(
                parameters: [
                    "username": username,
                    "password": password,
                    "email": email
                ],
                encoding: JSONEncoding.default
            )
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return nil
    }
}

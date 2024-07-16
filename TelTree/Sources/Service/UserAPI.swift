import Foundation
import UIKit
import Moya

enum UserAPI {
    case login(email: String, password: String)
    case signup
}

extension UserAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://")!
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
        case .login, .signup:
            return .post
        }
    }

    var task: Task {
        switch self {
        case let .login(email, password):
            return .requestParameters(
                parameters: [
                    "email": email,
                    "password": password
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

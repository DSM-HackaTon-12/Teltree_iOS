import Foundation
import UIKit
import Moya

enum PostAPI {
    case register(request: RegisterRequest, accessToken: String)
    case mainpage
}

extension PostAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://13.125.214.128:3000")!
    }

    var path: String {
        switch self {
        case .register:
            return "/post/create"
        case .mainpage:
            return "/post/mainpage"
        }
    }

    var method: Moya.Method {
        switch self {
        case .register:
            return .post
        case .mainpage:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case let .register(request, _):
            return .requestJSONEncodable(request)
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        
        switch self {
        case let .register(_, accessToken):
            return ["Authorization": "Barrer \(accessToken)"]
        case .mainpage:
            return Header.accessToken.header()
        }
    }
}

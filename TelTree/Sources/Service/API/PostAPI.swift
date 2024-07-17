import Foundation
import UIKit
import Moya

enum PostAPI {
    case register(request: RegisterRequest, token: String)
    case mainpage(token: String)
    case apply(postId: Int, token: String)
    case detail(postId: Int, token: String)
}

extension PostAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://54.180.237.248:3000")!
    }

    var path: String {
        switch self {
        case .register:
            return "/post/create"
        case .mainpage:
            return "/post/mainpage"
        case let .apply(postId, _):
            return "/post/apply/\(postId)"
        case let .detail(postId, _):
            return "/post/\(postId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .register:
            return .post
        case .mainpage, .detail:
            return .get
        case .apply:
            return .patch
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
        
        case .register(_ , token: let token), .mainpage(token: let token),.apply(_, token: let token), .detail(_, token: let token):
            return ["Authorization": "Barrer " + token]
        }
    }
}

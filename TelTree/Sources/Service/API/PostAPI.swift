import Foundation
import UIKit
import Moya

enum PostAPI {
    case register(request: RegisterRequest)
    case mainpage
    case apply(postId: Int)
    case detail(postId: Int)
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
        case let .apply(postId):
            return "/post/apply/\(postId)"
        case let .detail(postId):
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
        case let .register(request):
            return .requestJSONEncodable(request)
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        
        switch self {
        case .register, .mainpage, .apply, .detail:
            return ["Authorization": "Barrer " + Token.accessToken!]
        }
    }
}

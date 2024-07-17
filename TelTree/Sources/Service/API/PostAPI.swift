import Foundation
import UIKit
import Moya

enum PostAPI {
    case register(request: RegisterRequest)
    case detail(postId: Int)
}

extension PostAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://")!
    }

    var path: String {
        switch self {
        case .register:
            return "/post/create"
        case let .detail(postId):
            return "/post/\(postId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .register:
            return .post
        case .detail:
            return .get
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
        return nil
    }
}

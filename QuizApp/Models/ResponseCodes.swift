//
//  ResponseCodes.swift
//  QuizApp
//
//  Created by Andrea Omićević on 03/07/2020.
//  Copyright © 2020 Andrea Omićević. All rights reserved.
//

import Foundation

enum ResponseCodes: Int, Codable {
    case unathorized = 401
    case forbidden = 403
    case notFound = 404
    case badRequest = 400
    case ok = 200
    
    var code: Int {
        switch self {
        case .unathorized:
            return ResponseCodes.unathorized.rawValue
        case .forbidden:
            return ResponseCodes.forbidden.rawValue
        case .notFound:
            return ResponseCodes.notFound.rawValue
        case .badRequest:
            return ResponseCodes.badRequest.rawValue
        case .ok:
            return ResponseCodes.ok.rawValue
        }
    }
    
    var message: String {
        switch self {
        case .unathorized:
            return "Token isn't valid!"
        case .forbidden:
            return "User id and token doesn't match!"
        case .notFound:
            return "Quiz with given id does't exist!"
        case .badRequest:
            return "Time or number of correct question aren't valid!"
        case .ok:
            return "Success!"
        }
    }
}

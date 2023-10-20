//
//  ApiError.swift
//  GoBusNow
//
//  Created by alan on 2023/7/17.
//

import Foundation

enum ApiError: Error {
    case RequestUrlError(String)
    case DataTaskError(String)
    case DataNullError(String)
    case ResponseNullError(String)
    case ResponseError(String)
    case JsonError(String) 
}

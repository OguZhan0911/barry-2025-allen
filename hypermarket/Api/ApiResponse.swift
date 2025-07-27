//
//  ApiResponse.swift
//  hypermarket
//
//  Created by Barry Allen on 27/7/2025.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    let code: Int
    let data: T
    let msg: String
}


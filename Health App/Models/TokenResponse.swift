//
//  TokenResponse.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 29/12/2023.
//

import Foundation

struct TokenResponse: Codable {
    let expires_in: Int
    let token_type: String
    let scope: String
    let access_token: String
}

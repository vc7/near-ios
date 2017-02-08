//
//  NRParsingError.swift
//  near
//
//  Created by vincent on 2017/02/06.
//  Copyright © 2017年 vc7. All rights reserved.
//

import Foundation

enum NRParsingError: Error {
    /// JSON parsing error
    case parsingFailure
    
    var localizedDescription: String {
        switch self {
        case .parsingFailure:
            return "JSON parsing Failed."
        }
    }
}

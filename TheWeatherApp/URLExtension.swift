//
//  URLExtension.swift
//  TheWeatherApp
//
//  Created by Mahesh Jindal on 17/07/18.
//  Copyright © 2018 Mahesh Jindal. All rights reserved.
//

import Foundation


extension URL {
    func withQueries(_ queries: [String:String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

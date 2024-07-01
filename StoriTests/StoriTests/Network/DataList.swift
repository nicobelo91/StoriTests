//
//  DataList.swift
//  StoriTests
//
//  Created by Nicolas Cobelo on 29/06/2024.
//

import Foundation

/// Protocol to be applied to all API models
protocol APIModel: Codable {}

/// Generic struct representing array of data of specified type
struct DataList<T: APIModel>: APIModel {
    var results: [T]
    var page: Int
    var totalPages: Int
    var totalResults: Int
    
    enum CodingKeys: String, CodingKey {
            case page, results
            case totalPages = "total_pages"
            case totalResults = "total_results"
        }
}

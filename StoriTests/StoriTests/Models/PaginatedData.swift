//
//  PaginatedData.swift
//  StoriTests
//
//  Created by Nicolas Cobelo on 30/06/2024.
//

import Foundation

struct PaginatedData<T> {
    let data: [T]

    let page: Int
    let totalPages: Int
    let totalResults: Int
}

extension PaginatedData {
    static func empty() -> Self {
        .init(data: [], page: 0, totalPages: 0, totalResults: 0)
    }
}

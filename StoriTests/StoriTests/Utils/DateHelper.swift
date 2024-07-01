//
//  DateHelper.swift
//  StoriTests
//
//  Created by Nicolas Cobelo on 30/06/2024.
//

import Foundation

/// Static struct for date formatting and helper functions
struct DateHelper {
    /// Namespace enum containing static lazy DateFormatter instances
    enum Formatter {
        
        /// Formats dates in long format, e.g. `April 20, 2022` with GMT timezone
        static let longGMTDate: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateStyle = .long
            formatter.timeStyle = .none
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            return formatter
        }()
        
        /// Format is `yyyy-MM-dd`, eq. 2024-01-08
        static let dayComponents: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            return formatter
        }()

    }
}

//
//  DateUtils.swift
//  EventTracker
//
//  Created by Md. Yamin on 09.06.23.
//

import Foundation

class DateUtils {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    
    /**
     Returns a `String` representation of given `Date` object.
     - Parameter date: The specified `Date` that will be represented as a `String`.
     */
    static func formatDateToString(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    /**
     Returns a `Date` representation of given `String` object if the `Date` object is valid otherwise `null`.
     - Parameter value: The specified `String` that will be converted to a `Date` object or `null`.
     */
    static func formatStringToDate(value: String) -> Date? {
        return dateFormatter.date(from: value)
    }
    
    static func getOnlyDate(date: Date) -> Date {
        return formatStringToDate(value: formatDateToString(date: date))!
    }
}

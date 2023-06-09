//
//  Extensions.swift
//  EventTracker
//
//  Created by Md. Yamin on 09.06.23.
//

import Foundation
extension Calendar {
    /**
     Returns a list of `Date` objects where every `Date` denotes a day in the specified `Date` range.
     - Parameter startDate: The start of the specified `Date` range.
     - Parameter endDate: The end of the specified `Date` range.
     */
    func getDates(start startDate: Date, end endDate: Date, dayInterval: Int) -> [Date]  {
        guard startDate < endDate else { print("Start date must be less than end date!"); return [] }
        var dates: [Date] = []
        var date = startDate
        while date <= endDate {
            dates.append(date)
            date = Calendar.current.date(byAdding: .day, value: dayInterval, to: date)!
        }
        return dates
    }
}

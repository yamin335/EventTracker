//
//  EventModels.swift
//  EventTracker
//
//  Created by Md. Yamin on 09.06.23.
//

import Foundation

/// Defines all the types of `category` property that an event can have.
enum EventCategory: String, CaseIterable, Identifiable {
    case sick = "Sick", vacation = "Vacation", meeting = "Meeting"
    var id: Self { self }
}

/// Defines all the types of `repeatType` property that an event can have.
enum EventRepeatType: String, CaseIterable, Identifiable {
    case onTime = "On-Time", daily = "Daily", weekly = "Weekly"
    var id: Self { self }
}

/**
 An `Event` is a type of operation that specifies a certain work to be done at a certain time in a certain manner.
 */
struct Event: Identifiable, Hashable {
    let id = UUID()
    var tile: String
    var category: EventCategory
    var start: Date
    var end: Date
    var repeatType: EventRepeatType
    
    /**
     Returns a list of  valid `Date` objects on which the `Event` will take place in action in the specified `Date` range.
     - Parameter startDate: The start of the specified `Date` range.
     - Parameter endDate: The end of the specified `Date` range.
     */
    func findEvents(startDate: Date, endDate: Date) -> [Date] {
        guard startDate <= endDate else { print("Start date must be less than end date!"); return [] }
        
        switch repeatType {
        case .onTime:
            if start >= startDate && start <= endDate {
                return [start]
            } else {
                return []
            }
            
        case .daily:
            /**
             If `end` is less than `startDate` or `start` is greater than `endDate` then it's not necessary to check the validity at all,
             because the `Date`range is already out of valid `Date` boundaries.
             */
            if end < startDate {
                return []
            } else if start > endDate {
                return []
            } else if start <= startDate && end <= endDate {
                return getDailyEventDates(startDate: startDate, endDate: end)
            } else if start <= startDate && end >= endDate {
                return getDailyEventDates(startDate: startDate, endDate: endDate)
            } else if start >= startDate && end >= endDate {
                return getDailyEventDates(startDate: start, endDate: endDate)
            } else if start >= startDate && end <= endDate {
                return getDailyEventDates(startDate: start, endDate: end)
            } else {
                return []
            }
        case .weekly:
            /**
             If `end` is less than `startDate` or `start` is greater than `endDate` then it's not necessary to check the validity at all,
             because the `Date`range is already out of valid `Date` boundaries.
             */
            if end < startDate {
                return []
            } else if start > endDate {
                return []
            } else if start < startDate && end < endDate {
                return getWeeklyEventDates(startDate: startDate, endDate: end)
            } else if start < startDate && end > endDate {
                return getWeeklyEventDates(startDate: startDate, endDate: endDate)
            } else if start > startDate && end > endDate {
                return getWeeklyEventDates(startDate: start, endDate: endDate)
            } else if start > startDate && end < endDate {
                return getWeeklyEventDates(startDate: start, endDate: end)
            } else {
                return []
            }
        }
    }
    
    /**
     Returns a list of  valid `Date` objects on which the `Event` will take place in action once in a day in the specified `Date` range.
     - Parameter startDate: The start of the specified `Date` range.
     - Parameter endDate: The end of the specified `Date` range.
     */
    private func getDailyEventDates(startDate: Date, endDate: Date) -> [Date] {
        return Calendar.current.getDates(start: startDate, end: endDate, dayInterval: 1)
    }
    
    /**
     Returns a list of  valid `Date` objects on which the `Event` will take place in action once in a week in the specified `Date` range.
     - Parameter startDate: The start of the specified `Date` range.
     - Parameter endDate: The end of the specified `Date` range.
     */
    private func getWeeklyEventDates(startDate: Date, endDate: Date) -> [Date] {
        return Calendar.current.getDates(start: startDate, end: endDate, dayInterval: 7)
    }
}

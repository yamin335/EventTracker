//
//  EventTrackerTests.swift
//  EventTrackerTests
//
//  Created by Md. Yamin on 09.06.23.
//

import XCTest
@testable import EventTracker

final class EventTrackerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testOnTimeEvent() throws {
        // Event:
        // - start: 09-06-2023
        // - end: 09-06-2023
        // - pattern: .onTime
        let onTimeEvent = Event(
            tile: "On-Time Event", category: .meeting,
            start: DateUtils.formatStringToDate(value: "09-06-2023")!,
            end: DateUtils.formatStringToDate(value: "09-06-2023")!,
            repeatType: .onTime
        )
        
        // Input 1 ->  startDate: 09-06-2023, endDate: 09-06-2023
        // Output 1 ->  [09-06-2023]
        let output1: [Date] = [
            DateUtils.formatStringToDate(value: "09-06-2023")!
        ]
        
        XCTAssertEqual(
            onTimeEvent.findEvents(
                startDate: DateUtils.formatStringToDate(value: "09-06-2023")!,
                endDate: DateUtils.formatStringToDate(value: "09-06-2023")!
            ), output1
        )
        
        // Input 2 -> startDate: 10-06-2023, endDate: 10-06-2023
        // Output 2 -> []
        XCTAssertEqual(
            onTimeEvent.findEvents(
                startDate: DateUtils.formatStringToDate(value: "10-06-2023")!,
                endDate: DateUtils.formatStringToDate(value: "10-06-2023")!
            ), []
        )
    }

    func testDailyEvent() throws {
        // Event:
        // - start: 01-08-2022
        // - end: 03-08-2022
        // - pattern: .daily
        let dailyEvent = Event(
            tile: "Daily Event", category: .meeting,
            start: DateUtils.formatStringToDate(value: "01-08-2022")!,
            end: DateUtils.formatStringToDate(value: "03-08-2022")!,
            repeatType: .daily
        )
        
        // Input 1 ->  startDate: 20-07-2022, endDate: 30-08-2022
        // Output 1 ->  [01-08-2022, 02-08-2022, 03-08-2022]
        let output1: [Date] = [
            DateUtils.formatStringToDate(value: "01-08-2022")!,
            DateUtils.formatStringToDate(value: "02-08-2022")!,
            DateUtils.formatStringToDate(value: "03-08-2022")!
        ]
        
        XCTAssertEqual(
            dailyEvent.findEvents(
                startDate: DateUtils.formatStringToDate(value: "20-07-2022")!,
                endDate: DateUtils.formatStringToDate(value: "30-08-2022")!
            ), output1
        )
        
        // Input 2 -> startDate: 20-07-2022, endDate: 30-07-2022
        // Output 2 -> []
        XCTAssertEqual(
            dailyEvent.findEvents(
                startDate: DateUtils.formatStringToDate(value: "20-07-2022")!,
                endDate: DateUtils.formatStringToDate(value: "30-07-2022")!
            ), []
        )
    }

    func testWeeklyEvent() throws {
        // Event:
        // - start: 01-08-2022
        // - end: 22-08-2022
        // - pattern: .weekly
        let weeklyEvent = Event(
            tile: "Weekly Event", category: .meeting,
            start: DateUtils.formatStringToDate(value: "01-08-2022")!,
            end: DateUtils.formatStringToDate(value: "22-08-2022")!,
            repeatType: .weekly
        )
        
        
        // Input 1 ->  startDate: 20-07-2022, endDate: 30-08-2022
        // Output 1 ->  [01-08-2022, 08-08-2022, 15-08-2022, 22-08-2022]
        let output1: [Date] = [
            DateUtils.formatStringToDate(value: "01-08-2022")!,
            DateUtils.formatStringToDate(value: "08-08-2022")!,
            DateUtils.formatStringToDate(value: "15-08-2022")!,
            DateUtils.formatStringToDate(value: "22-08-2022")!
        ]
        
        XCTAssertEqual(
            weeklyEvent.findEvents(
                startDate: DateUtils.formatStringToDate(value: "20-07-2022")!,
                endDate: DateUtils.formatStringToDate(value: "30-08-2022")!
            ), output1
        )
        
        // Input 2 -> startDate: 20-07-2022, endDate: 30-07-2022
        // Output 2 -> []
        XCTAssertEqual(
            weeklyEvent.findEvents(
                startDate: DateUtils.formatStringToDate(value: "20-07-2022")!,
                endDate: DateUtils.formatStringToDate(value: "30-07-2022")!
            ), []
        )
    }
}

//
//  ViewModel.swift
//  EventTracker
//
//  Created by Md. Yamin on 09.06.23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var title: String = ""
    @Published var startDate = Date()
    @Published var endDate = Date()
    @Published var eventCategory: EventCategory = .meeting
    @Published var repeatType: EventRepeatType = .onTime
    
    var titleValidator: AnyPublisher<Bool, Never> {
        return $title
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { value in
                return value.isEmpty
        }
        .eraseToAnyPublisher()
    }
    
    func createEvent() {
        let event = Event(tile: title, category: eventCategory, start: DateUtils.getOnlyDate(date: startDate), end: DateUtils.getOnlyDate(date: endDate), repeatType: repeatType)
        events.append(event)
    }
    
    func clearForm() {
        title = ""
        startDate = Date()
        endDate = Date()
        eventCategory = .meeting
        repeatType = .onTime
    }
}

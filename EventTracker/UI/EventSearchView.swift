//
//  EventSearchView.swift
//  EventTracker
//
//  Created by Md. Yamin on 09.06.23.
//

import SwiftUI

struct EventSearchView: View {
    let event: Event
    @Binding var eventDates: [Date]
    @Binding var isPresented: Bool
    @State var startDate = Date()
    @State var endDate = Date()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Search Event")
                    .foregroundColor(Color("textColor1"))
                    .font(.system(size: 30, weight: .bold))
                    .padding(20)
                Spacer()
            }
            Form {
                Section {
                    DatePicker(
                        "Start Date",
                        selection: $startDate,
                        displayedComponents: [.date]
                    ).padding(.vertical, 5)
                    
                    DatePicker(
                        "End Date",
                        selection: $endDate,
                        in: startDate...,
                        displayedComponents: [.date]
                    ).padding(.vertical, 5)
                    
                    Button(action: {
                        eventDates = event.findEvents(startDate: DateUtils.getOnlyDate(date: startDate), endDate: DateUtils.getOnlyDate(date: endDate))
                        isPresented = false
                    }) {
                        HStack{
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(Color("green1"))
                            Text("Find Event Dates")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(Color("green1"))
                                
                            Spacer()
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 5, style: .circular)
                                .stroke(Color("green1"), lineWidth: 1)
                        )
                        .padding(.top, 16)
                        .padding(.bottom, 16)
                    }
                }
            }.navigationTitle("New Event")
            Spacer()
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

struct EventSearchView_Previews: PreviewProvider {
    @State static var isPresented: Bool = false
    @State static var eventDates: [Date] = []
    static let event = Event(tile: "Test Event", category: .meeting, start: Date(), end: Date(), repeatType: .daily)
    static var previews: some View {
        EventSearchView(event: event, eventDates: $eventDates, isPresented: $isPresented)
    }
}

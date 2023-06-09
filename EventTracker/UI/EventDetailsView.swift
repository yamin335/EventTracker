//
//  EventDetailsView.swift
//  EventTracker
//
//  Created by Md. Yamin on 09.06.23.
//

import SwiftUI

struct EventDetailsView: View {
    let event: Event
    @State var eventDates: [Date] = []
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State var isPresented: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                VStack(spacing: 8) {
                    Text("**Start date:** \(DateUtils.formatDateToString(date: event.start))")
                        .foregroundColor(Color("textColor1"))
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("**End date:** \(DateUtils.formatDateToString(date: event.end))")
                        .foregroundColor(Color("textColor1"))
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("**Event type:** \(event.category.rawValue)")
                        .foregroundColor(Color("textColor1"))
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("**Repeats:** \(event.repeatType.rawValue)")
                        .foregroundColor(Color("textColor1"))
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                }.padding([.horizontal, .top], 20)
                
                Divider()
                
                HStack(alignment: .center, spacing: 10) {
                    Spacer()
                    
                    Button(action: {
                        if isPresented != true {
                            isPresented = true
                        }
                    }) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 20, weight: .regular))
                            Text("Find all scheduled dates")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(Color("blue1"))
                                
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 5, style: .circular)
                                .stroke(Color("blue1"), lineWidth: 1)
                        )
                    }
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
            }.background(Color("gray1"))
            .clipped()
            .cornerRadius(5)
            .shadow(color: Color("shadowColor"), radius: 3)
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            
            if eventDates.isEmpty {
                Spacer()
                
                VStack(spacing: 10) {
                    Text("No event date found")
                        .foregroundColor(Color("gray2"))
                        .font(.system(size: 24))
                    HStack {
                        Text("Click above button to search event dates")
                            .foregroundColor(Color("textColor1"))
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                    }
                }.frame(minWidth: 0, maxWidth: .infinity)
                .padding(16)
                .background(Color("gray1"))
                .cornerRadius(5)
                .padding(16)
                
                Spacer()
                
            } else {
                ScrollView {
                    VStack {
                        Text("Next event dates are")
                            .foregroundColor(Color("textColor1"))
                            .font(.system(size: 24, weight: .bold))
                            .padding([.bottom, .leading], 20)
                        
                        LazyVGrid(columns: gridItemLayout, spacing: 8) {
                            ForEach(eventDates.indices, id: \.self) { index in
                                VStack(spacing: 5) {
                                    Text(DateUtils.formatDateToString(date: eventDates[index]))
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(Color("textColor1"))
                                        
                                }.padding(4)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .circular)
                                        .stroke(Color("blue1"), lineWidth: 1)
                                )
                            }
                        }
                    }
                    .padding(.bottom, 30)
                    .padding(.horizontal, 8)
                    .padding(.top, 10)
                }
            }
        }
        .navigationTitle(event.tile)
        .sheet(isPresented: $isPresented) {
            EventSearchView(event: event, eventDates: $eventDates, isPresented: $isPresented)
                .presentationDetents([.medium])
                .presentationCornerRadius(20)
                .presentationDragIndicator(.visible)
        }
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailsView(event: Event(tile: "Test Event", category: .meeting, start: Date(), end: Date(), repeatType: .daily))
    }
}

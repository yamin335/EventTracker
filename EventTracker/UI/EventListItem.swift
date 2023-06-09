//
//  EventListItem.swift
//  EventTracker
//
//  Created by Md. Yamin on 09.06.23.
//

import SwiftUI

struct EventListItem: View {
    let event: Event
    @Binding var path: NavigationPath
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(spacing: 8) {
                Text(event.tile)
                    .foregroundColor(Color("textColor1"))
                    .font(.system(size: 18, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Start date: \(DateUtils.formatDateToString(date: event.start))")
                    .foregroundColor(Color("textColor2"))
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("End date: \(DateUtils.formatDateToString(date: event.end))")
                    .foregroundColor(Color("textColor2"))
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Event type: \(event.category.rawValue)")
                    .foregroundColor(Color("textColor2"))
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Repeats: \(event.repeatType.rawValue)")
                    .foregroundColor(Color("textColor2"))
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
            }.padding([.horizontal, .top], 12)
            
            Divider()
            
            HStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Next event on")
                        .foregroundColor(Color("textColor4"))
                        .font(.system(size: 14))
                    Text(DateUtils.formatDateToString(date: event.start))
                        .foregroundColor(Color("textColor1"))
                        .font(.system(size: 14))
                }
                
                Spacer()
                
                Button(action: {
                    path.append(event)
                }) {
                    Text("Details")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color("blue1"))
                        .padding(.horizontal, 15)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 5, style: .circular)
                                .stroke(Color("blue1"), lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
        .background(.white)
        .clipped()
        .cornerRadius(5)
        .shadow(color: Color("shadowColor"), radius: 3)
        .padding(.horizontal, 16)
    }
}

struct EventListItem_Previews: PreviewProvider {
    @State static var path: NavigationPath = .init()
    static var previews: some View {
        EventListItem(event: Event(tile: "Test Event", category: .meeting, start: Date(), end: Date(), repeatType: .daily), path: $path)
    }
}

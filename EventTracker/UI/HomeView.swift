//
//  ContentView.swift
//  EventTracker
//
//  Created by Md. Yamin on 09.06.23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State var path: NavigationPath = .init()
    @State var isPresented: Bool = false
    
    var body: some View {
        NavigationStack(path: $path.animation(.easeOut)) {
            ZStack {
                if viewModel.events.isEmpty {
                    VStack(spacing: 10) {
                        Text("No event found")
                            .foregroundColor(Color("gray2"))
                            .font(.system(size: 24))
                        HStack {
                            Text("Click above '+ Add' button to add a new event")
                                .foregroundColor(Color("textColor1"))
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                        }
                    }.frame(minWidth: 0, maxWidth: .infinity)
                    .padding(16)
                    .background(Color("gray1"))
                    .cornerRadius(5)
                    .padding(16)
                    
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 20) {
                            ForEach(Array(viewModel.events.enumerated()), id: \.offset) { _, item in
                                EventListItem(event: item, path: $path)
                            }.padding(.top, 10)
                            Spacer()
                        }
                    }
                }
            }.navigationTitle("Event Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if isPresented != true {
                            isPresented = true
                        }
                    }) {
                        HStack {
                            Image(systemName: "plus")
                                .font(.system(size: 14, weight: .regular))
                            Text("Add")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(Color("blue1"))
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 5, style: .circular)
                                .stroke(Color("blue1"), lineWidth: 1)
                        )
                    }
                }
            }
            .navigationDestination(for: Event.self) { event in
                EventDetailsView(event: event)
            }
        }.sheet(isPresented: $isPresented) {
            EventGeneratorView(viewModel: viewModel, isPresented: $isPresented)
                .presentationDetents([.large])
                .presentationCornerRadius(20)
                .presentationDragIndicator(.visible)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

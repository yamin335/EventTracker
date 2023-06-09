//
//  EventGeneratorView.swift
//  EventTracker
//
//  Created by Md. Yamin on 09.06.23.
//

import SwiftUI

struct EventGeneratorView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Binding var isPresented: Bool
    @State var isEmpty: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("New Event")
                    .foregroundColor(Color("textColor1"))
                    .font(.system(size: 30, weight: .bold))
                    .padding(20)
                Spacer()
            }
            Form {
                Section {
                    LabeledContent("Event") {
                        TextField("name", text: $viewModel.title)
                            .textFieldStyle(RoundedBorderTextFieldStyle()).cornerRadius(5)
                            .padding(.leading, 20)
                    }.padding(.vertical, 5)
                    
                    DatePicker(
                        "Start Date",
                        selection: $viewModel.startDate,
                        displayedComponents: [.date]
                    ).padding(.vertical, 5)
                    
                    DatePicker(
                        "End Date",
                        selection: $viewModel.endDate,
                        displayedComponents: [.date]
                    ).padding(.vertical, 5)
                    
                    Picker("Event Type", selection: $viewModel.eventCategory) {
                        ForEach(EventCategory.allCases) { category in
                            Text(category.rawValue)
                        }
                    }.padding(.vertical, 5)
                    
                    Picker("Repeat Status", selection: $viewModel.repeatType) {
                        ForEach(EventRepeatType.allCases) { type in
                            Text(type.rawValue)
                        }
                    }.padding(.vertical, 5)
                    
                    Button(action: {
                        viewModel.createEvent()
                        viewModel.clearForm()
                        isPresented = false
                    }) {
                        HStack{
                            Spacer()
                            Image(systemName: "checkmark")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(isEmpty ? Color("gray2") : Color("green1"))
                            Text("Save Event")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(isEmpty ? Color("gray2") : Color("green1"))
                                
                            Spacer()
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 5, style: .circular)
                                .stroke(isEmpty ? Color("gray2") : Color("green1"), lineWidth: 1)
                        )
                        .padding(.top, 16)
                        .padding(.bottom, 16)
                    }
                    .disabled(isEmpty)
                    .onReceive(viewModel.titleValidator) { isEmpty in
                        self.isEmpty = isEmpty
                    }
                }
            }.navigationTitle("New Event")
            Spacer()
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

struct EventGeneratorView_Previews: PreviewProvider {
    @State static var isPresented: Bool = false
    static var previews: some View {
        EventGeneratorView(viewModel: HomeViewModel(), isPresented: $isPresented)
    }
}

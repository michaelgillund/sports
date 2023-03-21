//
//  DatePickerView.swift
//  FinalProject
//
//  Created by Michael Gillund on 3/20/23.
//

import SwiftUI

struct DatePickerView: View {
    @State private var selectedDate = Date()

    var body: some View {
        TabView {
            VStack{
                Spacer()
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .labelsHidden()
                .datePickerStyle(.graphical)
                .onChange(of: selectedDate, perform: { (value) in
                })
                .padding()
                Spacer()
            }
            .padding()
        }
    }
}


struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView()
    }
}

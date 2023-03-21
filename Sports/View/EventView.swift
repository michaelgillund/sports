//
//  EventView.swift
//  FinalProject
//
//  Created by Michael Gillund on 3/16/23.
//

import SwiftUI

struct EventView: View {
    
    var body: some View {
        ZStack {
            VStack{
                HStack{
                    Text("9:00 PM")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    Spacer()
                }
                HStack{
                    Circle()
                        .fill(Color(uiColor: .darkGray))
                        .frame(width: 30, height: 30)
                    Text("Chicago")
                        .font(.system(size: 18, weight: .heavy))
                    Spacer()
                    Text("123")
                        .font(.system(size: 18, weight: .heavy))
                }
                HStack{
                    Circle()
                        .fill(Color(uiColor: .darkGray))
                        .frame(width: 30, height: 30)
                    Text("Chicago")
                        .font(.system(size: 18, weight: .heavy))
                    Spacer()
                    Text("123")
                        .font(.system(size: 18, weight: .heavy))
                }
            }
            .padding()
            .background(Color(uiColor: .secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        }
        .padding()
        .redacted(reason: .placeholder)
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}

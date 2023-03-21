//
//  MatchupView.swift
//  FinalProject
//
//  Created by Michael Gillund on 3/16/23.
//

import SwiftUI

struct MatchupView: View {
    
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
                        .frame(width: 60, height: 60)
                    VStack(alignment: .leading) {
                        Text("CHI")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.gray)
                        Text("Chicago")
                            .font(.system(size: 22, weight: .heavy))
                        Text("64-45")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text("123")
                        .font(.system(size: 28, weight: .heavy))
                }
                HStack{
                    Circle()
                        .fill(Color(uiColor: .darkGray))
                        .frame(width: 60, height: 60)
                    VStack(alignment: .leading) {
                        Text("CHI")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.gray)
                        Text("Chicago")
                            .font(.system(size: 22, weight: .heavy))
                        Text("64-45")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text("123")
                        .font(.system(size: 28, weight: .heavy))
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

struct MatchupView_Previews: PreviewProvider {
    static var previews: some View {
        MatchupView()
    }
}

struct LinescoreView: View {

    var body: some View {
        ZStack {
            VStack{
                HStack{
                    Text("Scoring")
                        .font(.system(size: 16, weight: .bold))
                    Spacer()

                    ForEach(0...3, id: \.self) { index in
                        Text("\(index + 1)")
                            .font(.system(size: 14, weight: .regular))
                            .frame(maxWidth: 30)
                    }
                    Text("T")
                        .font(.system(size: 14, weight: .regular))
                        .frame(maxWidth: 30)
                }
                HStack{
                    Circle()
                        .fill(Color(uiColor: .darkGray))
                        .frame(width: 30, height: 30)
                    Text("CHI")
                        .font(.system(size: 16, weight: .regular))
                    Spacer()
                    ForEach(0...3, id: \.self) { index in
                        Text("\(index * 29)")
                            .font(.system(size: 14, weight: .regular))
                            .frame(width: 30)
                            .fixedSize()
                    }
                    Text("123")
                        .font(.system(size: 14, weight: .regular))
                        .frame(maxWidth: 30)
                }
                HStack{
                    Circle()
                        .fill(Color(uiColor: .darkGray))
                        .frame(width: 30, height: 30)
                    Text("CHI")
                        .font(.system(size: 16, weight: .regular))
                    Spacer()
                    ForEach(0...3, id: \.self) { index in
                        Text("\(index * 51)")
                            .font(.system(size: 14, weight: .regular))
                            .frame(width: 30)
                            .fixedSize()
                    }
                    Text("123")
                        .font(.system(size: 14, weight: .regular))
                        .frame(maxWidth: 30)
                }
            }
            .padding()
            .background(Color(uiColor: .secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        }
        .padding()
//        .redacted(reason: .placeholder)
    }
}

struct LinescoreView_Previews: PreviewProvider {
    static var previews: some View {
        LinescoreView()
    }
}

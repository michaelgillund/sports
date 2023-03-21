//
//  BoxscoreView.swift
//  FinalProject
//
//  Created by Michael Gillund on 3/16/23.
//

import SwiftUI

struct BoxscoreView: View {
    
    var body: some View {
        HStack(spacing: 6){
            Circle()
                .fill(Color(uiColor: .darkGray))
                .frame(width: 60, height: 60)
            VStack(spacing: 6) {
                HStack{
                    Text("Michael Gillund")
                        .font(.system(size: 18, weight: .bold))
                    Text("SG")
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .regular))
                    Spacer()
                    Text("23")
                        .font(.system(size: 14, weight: .regular))
                    Text("MIN")
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .regular))
                }
                HStack{
                    ForEach(0...6, id: \.self) { index in
                        VStack{
                            Text("23")
                                .font(.system(size: 14, weight: .regular))
                                .frame(maxWidth: .infinity)
                            Text("PTS")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .redacted(reason: .placeholder)
    }
}

struct BoxscoreView_Previews: PreviewProvider {
    static var previews: some View {
        BoxscoreView()
    }
}

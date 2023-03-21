//
//  Extension+Date.swift
//  FinalProject
//
//  Created by Michael Gillund on 2/23/23.
//

import Foundation

extension Date {
    
    func query() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: self)
    }
}

func GameTime(date: String) -> String {
    var output = ""
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mmZ"
    if let newDate = formatter.date(from: date){
        let display = DateFormatter()
        display.locale = Locale(identifier: "en_US")
        display.dateFormat = "h:mm a"
        output = display.string(from: newDate)
    }
    return output
}

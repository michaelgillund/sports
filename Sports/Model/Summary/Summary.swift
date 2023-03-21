//
//  Summary.swift
//  FinalProject
//
//  Created by Michael Gillund on 2/27/23.
//

import Foundation

struct Summary: Codable {
    
    let boxscore: Boxscore
    let seasonseries: [SeasonSeries]
    let header: Header
    let injuries: [Injury]?
    
}

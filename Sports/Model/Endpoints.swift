//
//  Endpoints.swift
//  FinalProject
//
//  Created by Michael Gillund on 2/23/23.
//

import Foundation

public enum Endpoints {
    
    case nfl
    case nba
    case mlb
    case nhl
          
    public func buildEvents() -> String {
        switch self {
            case .nfl:
                return "football/nfl/scoreboard"
            case .nba:
                return "basketball/nba/scoreboard"
            case .mlb:
                return "baseball/mlb/scoreboard"
            case .nhl:
                return "hockey/nhl/scoreboard"
        }
    }
    public func buildNews() -> String {
        switch self {
            case .nfl:
                return "football/nfl/news"
            case .nba:
                return "basketball/nba/news"
            case .mlb:
                return "baseball/mlb/news"
            case .nhl:
                return "hockey/nhl/news"
        }
    }
    var path: String {
        switch self {
        case .nfl:
            return "NFL"
        case .nba:
            return "NBA"
        case .mlb:
            return "MLB"
        case .nhl:
            return "NHL"
        }
    }
}

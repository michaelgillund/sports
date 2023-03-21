//
//  SeasonSeries.swift
//  FinalProject
//
//  Created by Michael Gillund on 3/16/23.
//

import Foundation

extension Summary {
    
    struct SeasonSeries: Codable {
        struct Event: Codable {
            struct StatusType: Codable {
                let id: String?
                let name: String?
                let state: String?
                let completed: Bool?
                let description: String?
                let detail: String?
                let shortDetail: String?
            }
            
            struct Competitor: Codable {
                struct Team: Codable {
                    struct Link: Codable {
                        let href: String?
                        let text: String?
                    }
                    
                    let id: String?
                    let uid: String?
                    let displayName: String?
                    let abbreviation: String?
                    let links: [Link]?
                    let logo: String?
                }
                
                let homeAway: String?
                let winner: Bool?
                let team: Team?
                let score: String?
                
            }
            
            struct Link: Codable {
                let language: String?
                let rel: [String]?
                let href: String?
                let text: String?
                let shortText: String?
                let isExternal: Bool?
                let isPremium: Bool?
            }
            
            let id: String?
            let uid: String?
            let date: String?
            let timeValid: Bool?
            let status: String
            let statusType: StatusType?
            let competitors: [Competitor]?
            let links: [Link]?
            
            var league: String {
                let link = links?[0].href ?? ""
                
                switch link {
                case let link where link.contains("nfl"):
                    return "nfl"
                case let link where link.contains("nba"):
                    return "nba"
                case let link where link.contains("mlb"):
                    return "mlb"
                case let link where link.contains("nhl"):
                    return "nhl"
                case let link where link.contains("ncaaf"):
                    return "ncaaf"
                case let link where link.contains("ncaab"):
                    return "ncaab"
                case let link where link.contains("mls"):
                    return "mls"
                case let link where link.contains("epl"):
                    return "epl"
                case let link where link.contains("wnba"):
                    return "wnba"
                case let link where link.contains("wncaa"):
                    return "wncaa"
                default:
                    return ""
                }
            }
            
            var live: Bool {
                var valid: Bool
                let state = status
                if state.hasPrefix("pre") || state.hasPrefix("post"){
                    valid = false
                }else{
                    valid = true
                }
                return valid
            }
            var pre: Bool {
                var valid: Bool
                let state = status
                if state.hasPrefix("pre"){
                    valid = true
                }else{
                    valid = false
                }
                return valid
            }
            var post: Bool{
                var valid: Bool
                let state = status
                if state.hasPrefix("post"){
                    valid = true
                }else{
                    valid = false
                }
                return valid
            }
            
            var gametime: String {
                return statusType?.shortDetail ?? ""
            }
            var homeName: String {
                return competitors?[0].team?.displayName ?? ""
            }
            var homeScore: String {
                let score = competitors?[0].score ?? ""
                var value = ""
                if !status.hasPrefix("post") || !status.hasPrefix("postponed") {
                    if !score.hasPrefix("0"){
                        value = score
                    }
                }else{
                    value = score
                }
                return value
            }
            
            var homeImage: String {
                return competitors?[0].team?.logo ?? ""
            }
            var homeImageDark: String {
                var str = competitors?[0].team?.logo ?? ""
                if let i = str.firstIndex(of: "5") {
                    let value = i.utf16Offset(in:str)
                    str.insert("-", at: str.index(str.startIndex, offsetBy: value + 3))
                    str.insert("d", at: str.index(str.startIndex, offsetBy: value + 4))
                    str.insert("a", at: str.index(str.startIndex, offsetBy: value + 5))
                    str.insert("r", at: str.index(str.startIndex, offsetBy: value + 6))
                    str.insert("k", at: str.index(str.startIndex, offsetBy: value + 7))
                }else{
                    print("Not Found")
                }
                return str
            }
            var awayName: String {
                return competitors?[1].team?.displayName ?? ""
            }
            var awayScore: String {
                let score = competitors?[1].score ?? ""
                var value = ""
                if !status.hasPrefix("post") || !status.hasPrefix("postponed") {
                    if !score.hasPrefix("0"){
                        value = score
                    }
                }else{
                    value = score
                }
                return value
            }
            var awayImage: String {
                return competitors?[1].team?.logo ?? ""
            }
            var awayImageDark: String {
                var str = competitors?[1].team?.logo ?? ""
                if let i = str.firstIndex(of: "5") {
                    let value = i.utf16Offset(in:str)
                    str.insert("-", at: str.index(str.startIndex, offsetBy: value + 3))
                    str.insert("d", at: str.index(str.startIndex, offsetBy: value + 4))
                    str.insert("a", at: str.index(str.startIndex, offsetBy: value + 5))
                    str.insert("r", at: str.index(str.startIndex, offsetBy: value + 6))
                    str.insert("k", at: str.index(str.startIndex, offsetBy: value + 7))
                }else{
                    print("Not Found")
                }
                return str
            }
        }
        
        let type: String?
        let title: String?
        let description: String?
        let summary: String?
        let completed: Bool?
        let totalCompetitions: Int?
        let events: [Event]?
    }
}

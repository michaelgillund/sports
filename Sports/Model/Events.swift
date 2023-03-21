//
//  Events.swift
//  FinalProject
//
//  Created by Michael Gillund on 2/23/23.
//

import Foundation

struct Events: Codable {
    
    let events: [Event]
    
    
    // MARK: - Event
    struct Event: Codable {
        
        let id: String
        let date: String?
        let competitions: [Competition]?
        let links: [Link]?
        let status: Status?
        
        
        var sorted: String {
            var value: String = ""
            let state = status?.type?.state ?? ""
            if state.hasPrefix("pre"){
                value = "B"
            }else if state.hasPrefix("in"){
                value = "A"
            }else if state.hasPrefix("post"){
                value = "C"
            }
            return value
        }
        
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
        
        
        // MARK: - Game Info
        var gametime: String {
            var time: String = ""
            let state = status?.type?.state ?? ""
            
            if state.hasPrefix("pre"){
                time = GameTime(date: date ?? "")
            }else{
                
                time = status?.type?.shortDetail ?? ""
                
                let remove_one = "-"
                if let range_one = time.range(of: remove_one) {
                    time.removeSubrange(range_one)
                }
                
                let remove_two = "of "
                if let range_two = time.range(of: remove_two) {
                    time.removeSubrange(range_two)
                }
                
            }
            return time
        }
        var state: String {
            return status?.type?.state ?? ""
        }
        
        // MARK: - Game States
        var live: Bool {
            var valid: Bool
            let state = status?.type?.state ?? ""
            if state.hasPrefix("pre") || state.hasPrefix("post"){
                valid = false
            }else{
                valid = true
            }
            return valid
        }
        var pre: Bool {
            var valid: Bool
            let state = status?.type?.state ?? ""
            if state.hasPrefix("pre"){
                valid = true
            }else{
                valid = false
            }
            return valid
        }
        var post: Bool{
            var valid: Bool
            let state = status?.type?.state ?? ""
            if state.hasPrefix("post"){
                valid = true
            }else{
                valid = false
            }
            return valid
        }
        
        // MARK: - Home Team
        var homeAbv: String {
            return competitions?[0].competitors?[0].team?.abbreviation ?? ""
        }
        var homeName: String {
            return competitions?[0].competitors?[0].team?.shortDisplayName ?? ""
        }
        var homeImage: String {
            let str = competitions?[0].competitors?[0].team?.logo ?? ""
            return str
        }
        var homeImageDark: String {
            var str = competitions?[0].competitors?[0].team?.logo ?? ""
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
        var homeScore: String {
            var score: String  = ""
            let description = status?.type?.description ?? ""
            if description.hasPrefix("Scheduled"){
                score = ""
            }else{
                score = competitions?[0].competitors?[0].score ?? ""
            }
            return score
        }
        var homeLinescore: [Competition.Competitor.Linescore]{
            return competitions?[0].competitors?[0].linescores ?? []
        }
        
        // MARK: - Away Team
        var awayAbv: String {
            return competitions?[0].competitors?[1].team?.abbreviation ?? ""
        }
        var awayName: String {
            return competitions?[0].competitors?[1].team?.shortDisplayName ?? ""
        }
        var awayImage: String {
            let str = competitions?[0].competitors?[1].team?.logo ?? ""
            return str
        }
        var awayImageDark: String {
            var str = competitions?[0].competitors?[1].team?.logo ?? ""
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
        var awayScore: String {
            var score: String  = ""
            let description = status?.type?.description ?? ""
            if description.hasPrefix("Scheduled"){
                score = ""
            }else{
                score = competitions?[0].competitors?[1].score ?? ""
            }
            return score
        }
        var awayLinescore: [Competition.Competitor.Linescore]{
            return competitions?[0].competitors?[1].linescores ?? []
        }
        
        
        // MARK: - Competition
        struct Competition: Codable {
            
            let id: String?
            let date: String?
            let competitors: [Competitor]?
            let status: Status?
            
            // MARK: - Competitor
            struct Competitor: Codable {
                
                let id: String?
                let uid: String?
                let team: Team?
                let score: String?
                let linescores: [Linescore]?
                
                // MARK: - Team
                struct Team: Codable {
                    
                    let id: String?
                    let name: String?
                    let abbreviation: String?
                    let displayName: String?
                    let shortDisplayName: String?
                    let color: String?
                    let logo: String?
                    
                }
                // MARK: - Linescore
                struct Linescore: Codable {
                    let value: Int?
                    
                    enum CodingKeys: String, CodingKey{
                        case value
                    }
                }
            }
            
            // MARK: - Status
            struct Status: Codable {
                
                let clock: Double?
                let displayClock: String?
                let period: Int?
                let type: `Type`?
                
                // MARK: - `Type`
                struct `Type`: Codable {
                    let id: String?
                    let name: String?
                    let state: String?
                    let completed: Bool?
                    let description: String?
                    let detail: String?
                    let shortDetail: String?
                }
            }
            
        }
        
        // MARK: - Link
        struct Link: Codable {
            let href: String?
        }
        
        // MARK: - Status
        struct Status: Codable {
            
            let clock: Double?
            let displayClock: String?
            let period: Int?
            let type: `Type`?
            
            // MARK: - `Type`
            struct `Type`: Codable {
                let id: String?
                let name: String?
                let state: String?
                let completed: Bool?
                let description: String?
                let detail: String?
                let shortDetail: String?
            }
        }
        
    }
    
}

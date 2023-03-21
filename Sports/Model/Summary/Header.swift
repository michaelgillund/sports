//
//  Header.swift
//  FinalProject
//
//  Created by Michael Gillund on 3/16/23.
//

import Foundation

extension Summary {
    
    struct Header: Codable {
        
        struct Season: Codable {
            let year: Int?
            let type: Int?
        }
        
        struct Competition: Codable {
            
            struct Competitor: Codable {
                
                struct Team: Codable {
                    
                    struct Logo: Codable {
                        let href: String?
                    }
                    
                    let id: String?
                    let uid: String?
                    let location: String?
                    let name: String?
                    let abbreviation: String?
                    let displayName: String?
                    let color: String?
                    let alternateColor: String?
                    let logos: [Logo]?
                }
                
                struct Linescore: Codable {
                    let displayValue: String?
                }
                
                struct Record: Codable {
                    let type: String?
                    let summary: String?
                    let displayValue: String?
                }
                
                let id: String?
                let uid: String?
                let order: Int?
                let homeAway: String?
                let winner: Bool?
                let team: Team?
                let score: String?
                let linescores: [Linescore]?
                let record: [Record]?
                let possession: Bool?
                
            }
            
            struct Status: Codable {
                
                struct `Type`: Codable {
                    let id: String?
                    let name: String?
                    let state: String?
                    let completed: Bool?
                    let description: String?
                    let detail: String?
                    let shortDetail: String?
                }
                
                let type: `Type`?
            }
            
            let id: String?
            let uid: String?
            let date: String?
            let neutralSite: Bool?
            let conferenceCompetition: Bool?
            let boxscoreAvailable: Bool?
            let commentaryAvailable: Bool?
            let liveAvailable: Bool?
            let shotChartAvailable: Bool?
            let timeoutsAvailable: Bool?
            let possessionArrowAvailable: Bool?
            let onWatchESPN: Bool?
            let recent: Bool?
            let boxscoreSource: String?
            let playByPlaySource: String?
            let competitors: [Competitor]?
            let status: Status?
            
        }
        
        struct Link: Codable {
            let rel: [String]?
            let href: String?
            let text: String?
            let shortText: String?
            let isExternal: Bool?
            let isPremium: Bool?
        }
        
        struct League: Codable {
            struct Link: Codable {
                let rel: [String]?
                let href: String?
                let text: String?
            }
            
            let id: String?
            let uid: String?
            let name: String?
            let abbreviation: String?
            let slug: String?
            let isTournament: Bool?
            let links: [Link]?
        }
        
        let id: String?
        let uid: String?
        let season: Season?
        let timeValid: Bool?
        let competitions: [Competition]?
        let links: [Link]?
        let league: League?
        
        
        // MARK: - Game Info
        var date: String {
            return  GameTime(date: competitions?[0].date ?? "")
        }
        var gametime: String {
            var time: String = ""
            let state = competitions?[0].status?.type?.state ?? ""
            
            if state.hasPrefix("pre"){
                time = GameTime(date: competitions?[0].date ?? "")
            }else{
                
                time = competitions?[0].status?.type?.shortDetail ?? ""
                
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
            return competitions?[0].status?.type?.state ?? ""
        }
        var description: String {
            return competitions?[0].status?.type?.description ?? ""
        }
        
        // MARK: - Game States
        var live: Bool {
            var valid: Bool
            let state = competitions?[0].status?.type?.state ?? ""
            if state.hasPrefix("pre") || state.hasPrefix("post"){
                valid = false
            }else{
                valid = true
            }
            return valid
        }
        var pre: Bool {
            var valid: Bool
            let state = competitions?[0].status?.type?.state ?? ""
            if state.hasPrefix("pre"){
                valid = true
            }else{
                valid = false
            }
            return valid
        }
        var post: Bool{
            var valid: Bool
            let state = competitions?[0].status?.type?.state ?? ""
            if state.hasPrefix("post"){
                valid = true
            }else{
                valid = false
            }
            return valid
        }
        
        // MARK: - Home Team
        var homeName: String {
            return competitions?[0].competitors?[0].team?.name ?? ""
        }
        var homeImage: String {
            let str = competitions?[0].competitors?[0].team?.logos?[0].href ?? ""
            return str
        }
        var homeImageDark: String {
            let str = competitions?[0].competitors?[0].team?.logos?[1].href ?? ""
            return str
        }
        var homeScore: String {
            var score: String  = ""
            let description = competitions?[0].status?.type?.description ?? ""
            if description.hasPrefix("Scheduled"){
                score = ""
            }else{
                score = competitions?[0].competitors?[0].score ?? ""
            }
            return score
        }
        var homeAbv: String {
            return competitions?[0].competitors?[0].team?.abbreviation ?? ""
        }
        var homeRecord: String {
            return competitions?[0].competitors?[0].record?[0].displayValue ?? ""
        }
        var homeColor: String {
            return competitions?[0].competitors?[0].team?.color ?? ""
        }
        var homeLinescore: [Competition.Competitor.Linescore]{
            return competitions?[0].competitors?[0].linescores ?? []
        }
        
        // MARK: - Away Team
        var awayName: String {
            return competitions?[0].competitors?[1].team?.name ?? ""
        }
        var awayImage: String {
            let str = competitions?[0].competitors?[1].team?.logos?[0].href ?? ""
            return str
        }
        var awayImageDark: String {
            let str = competitions?[0].competitors?[1].team?.logos?[1].href ?? ""
            return str
        }
        var awayScore: String {
            var score: String  = ""
            let description = competitions?[0].status?.type?.description ?? ""
            if description.hasPrefix("Scheduled"){
                score = ""
            }else{
                score = competitions?[0].competitors?[1].score ?? ""
            }
            return score
        }
        var awayAbv: String {
            return competitions?[0].competitors?[1].team?.abbreviation ?? ""
        }
        var awayRecord: String {
            return competitions?[0].competitors?[1].record?[0].displayValue ?? ""
        }
        var awayColor: String {
            return competitions?[0].competitors?[1].team?.color ?? ""
        }
        var awayLinescore: [Competition.Competitor.Linescore]{
            return competitions?[0].competitors?[1].linescores ?? []
        }
        
        
    }
}

//
//  Boxscore.swift
//  FinalProject
//
//  Created by Michael Gillund on 3/7/23.
//

import Foundation

extension Summary {
    
    struct Boxscore: Codable {
        
        let teams: [Team]?
        let players: [Player]?
        
        var statAway: [Summary.Boxscore.Player.Statistic] {
            return players?[0].statistics ?? []
        }
        var statHome: [Summary.Boxscore.Player.Statistic] {
            return players?[1].statistics ?? []
        }
        var athletesAway: [Summary.Boxscore.Player.Statistic.Athlete]{
            return players?[0].statistics?[0].athletes ?? []
        }
        var athletesHome: [Summary.Boxscore.Player.Statistic.Athlete]{
            return players?[1].statistics?[0].athletes ?? []
        }
        var starterAway: [Summary.Boxscore.Player.Statistic.Athlete]{
            return players?[0].statistics?[0].athletes?.filter({ $0.starter == true}) ?? []
        }
        var benchAway: [Summary.Boxscore.Player.Statistic.Athlete]{
            return players?[0].statistics?[0].athletes?.filter({ $0.starter == false}) ?? []
        }
        var starterHome: [Summary.Boxscore.Player.Statistic.Athlete]{
            return players?[1].statistics?[0].athletes?.filter({ $0.starter == true}) ?? []
        }
        var benchHome: [Summary.Boxscore.Player.Statistic.Athlete]{
            return players?[1].statistics?[0].athletes?.filter({ $0.starter == false}) ?? []
        }
        
        struct Team: Codable {
            
            let team: Team?
            let statistics: [Statistic]?
            
            struct Team: Codable {
                let id: String?
                let uid: String?
                let slug: String?
                let location: String?
                let name: String?
                let abbreviation: String?
                let displayName: String?
                let shortDisplayName: String?
                let color: String?
                let alternateColor: String?
                let logo: String?
            }
            
            struct Statistic: Codable {
                let name: String?
                let displayValue: String?
                let label: String?
                let abbreviation: String?
            }
        }
        
        struct Player: Codable {
            
            let team: Team?
            let statistics: [Statistic]?
            
            struct Team: Codable {
                let id: String?
                let uid: String?
                let slug: String?
                let location: String?
                let name: String?
                let abbreviation: String?
                let displayName: String?
                let shortDisplayName: String?
                let color: String?
                let alternateColor: String?
                let logo: String?
            }
            
            struct Statistic: Codable {
                
                let name: String?
                let type: String?
                let names: [String]?
                let keys: [String]?
                let labels: [String]
                let descriptions: [String]?
                let athletes: [Athlete]?
                let totals: [String]?
                
//                var athlete: [Athlete] {
//                    let value = athletes?.sorted(by: {
//                        let x = Int($0.min)
//                        let y = Int($1.min)
//
//                        return x ?? 0 > y ?? 0
//                    }) ?? []
//                    return value
//                }
                
                var nbaLabels: [String] {
                    var value: [String] = []
                    for index in labels.indices {
                        if index == 1 {
                            value.append(labels[index])
                        }
                        else if index == 2 {
                            value.append(labels[index])
                        }
                        else if index == 3 {
                            value.append(labels[index])
                        }
                        else if index == 6 {
                            value.append(labels[index])
                        }
                        else if index == 7 {
                            value.append(labels[index])
                        }
                        else if index == 13 {
                            value.append(labels[index])
                        }
                        
                    }
                    let initial = value
                    let positions = [4,6,5,2,3,1]
                    var new = Array(zip(initial, positions))
                    new = new.sorted(by:{$0.1 < $1.1})
                    let sorted = new.map(){$0.0}
                    return sorted
                }
                
                
                var mlbBattingLabels: [String] {
                    let mlbBattingIndices = [1, 2, 3, 4, 5, 6, 7, 9]
                    return mlbBattingIndices.map { labels[$0] }
                }
                
                var mlbPitchingLabels: [String] {
                    let mlbPitchingIndices = [0, 1, 2, 4, 5, 6, 8]
                    return mlbPitchingIndices.map { labels[$0] }
                }
                var nhlForDefLabels: [String] {
                    let nhlForDefIndices = [1, 4, 9, 11, 12]
                    return nhlForDefIndices.map { labels[$0] }
                }
                
                var nhlGoalieLabels: [String] {
                    let nhlGoalieIndices = [0, 1, 2, 4, 5, 9]
                    return nhlGoalieIndices.map { labels[$0] }
                }
                
                struct Athlete: Codable {
                    
                    let active: Bool?
                    let athlete: Athlete?
                    let starter: Bool?
                    let didNotPlay: Bool?
                    let reason: String?
                    let ejected: Bool?
                    var stats: [String]
                    
                    var min: String {
                        let value = stats.prefix(1)
                        return value.first ?? "0"
                    }
                    
                    var nbaStats: [String] {
                        var value: [String] = []
                        for index in stats.indices {
                            if index == 1 {
                                value.append(stats[index])
                            }
                            else if index == 2 {
                                value.append(stats[index])
                            }
                            else if index == 3 {
                                value.append(stats[index])
                            }
                            else if index == 6 {
                                value.append(stats[index])
                            }
                            else if index == 7 {
                                value.append(stats[index])
                            }
                            else if index == 13 {
                                value.append(stats[index])
                            }
                            
                        }
                        let initial = value
                        let positions = [4,6,5,2,3,1]
                        var new = Array(zip(initial, positions))
                        new = new.sorted(by:{$0.1 < $1.1})
                        let sorted = new.map(){$0.0}
                        return sorted
                    }
                    var mlbBattingStats: [String] {
                        let indices = [1, 2, 3, 4, 5, 6, 7, 9]
                        return indices.compactMap { stats.indices.contains($0) ? stats[$0] : nil }
                    }
                    
                    var mlbPitchingStats: [String] {
                        let indices = [0, 1, 2, 4, 5, 6, 8]
                        return indices.compactMap { stats.indices.contains($0) ? stats[$0] : nil }
                    }
                    
                    var nhlForDefStats: [String] {
                        let indices = [1, 4, 9, 11, 12]
                        return indices.compactMap { stats.indices.contains($0) ? stats[$0] : nil }
                    }
                    var nhlGoalieStats: [String] {
                        let indices = [0, 1, 2, 4, 5, 9]
                        return indices.compactMap { stats.indices.contains($0) ? stats[$0] : nil }
                    }
                    
                    struct Athlete: Codable {
                        
                        let id: String?
                        let uid: String?
                        let guid: String?
                        let displayName: String?
                        let shortName: String?
                        let links: [Link]?
                        let headshot: Headshot?
                        let jersey: String?
                        let position: Position?
                        
                        struct Link: Codable {
                            let rel: [String]?
                            let href: String?
                            let text: String?
                        }
                        
                        struct Headshot: Codable {
                            let href: String?
                            let alt: String?
                        }
                        
                        struct Position: Codable {
                            let name: String?
                            let displayName: String?
                            let abbreviation: String?
                        }
                    }
                }
            }
        }
    }
}

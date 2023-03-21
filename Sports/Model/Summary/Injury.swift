//
//  Injury.swift
//  FinalProject
//
//  Created by Michael Gillund on 3/16/23.
//

import Foundation

extension Summary {
    
    struct Injury: Codable {
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
        
        struct Injury: Codable {
            struct Athlete: Codable {
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
                
                let id: String?
                let uid: String?
                let guid: String?
                let lastName: String?
                let fullName: String?
                let displayName: String?
                let shortName: String?
                let links: [Link]?
                let headshot: Headshot?
                let jersey: String?
                let position: Position?
            }
            
            struct `Type`: Codable {
                let id: String?
                let name: String?
                let description: String?
                let abbreviation: String?
            }
            
            struct Detail: Codable {
                struct FantasyStatus: Codable {
                    let description: String?
                    let abbreviation: String?
                }
                
                let fantasyStatus: FantasyStatus?
                let type: String?
                let location: String?
                let detail: String?
                let side: String?
                let returnDate: String?
            }
            
            let status: String?
            let date: String?
            let athlete: Athlete?
            let type: `Type`?
            let details: Detail?
        }
        
        let team: Team?
        let injuries: [Injury]?
    }
}

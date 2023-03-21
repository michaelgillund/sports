//
//  Articles.swift
//  FinalProject
//
//  Created by Michael Gillund on 2/24/23.
//

import Foundation

struct Articles: Codable {
    
    struct Article: Codable {
        
        struct Image: Codable {
            let name: String?
            let alt: String?
            let caption: String?
            let url: String?
            let type: String?
            
        }
        
        struct Link: Codable {
            
            struct Web: Codable {
                let href: String?
            }
            struct Mobile: Codable {
                let href: String?
            }
            
            let web: Web?
            let mobile: Mobile?
        }
        
        let images: [Image]?
        let description: String?
        let published: String?
        let type: String?
        let links: Link?
        let lastModified: String?
        let headline: String?
        let byline: String?
    }
    
    let header: String?
    let articles: [Article]
}

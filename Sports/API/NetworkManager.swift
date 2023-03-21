//
//  NetworkManager.swift
//  FinalProject
//
//  Created by Michael Gillund on 2/23/23.
//

import Foundation

class NetworkManager {
    
    public func getEvents(endpoint: Endpoints, date: String, completion: @escaping (Result<[Events.Event], Error>) -> ())  {
        let url = URL(string: "https://site.api.espn.com/apis/site/v2/sports/")!
        let final = url.appendingPathComponent(endpoint.buildEvents())
        var components = URLComponents(url: final, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "dates", value: date),
        ]
        let request = URLRequest(url: components.url!)
        let task = URLSession.shared.dataTask(with: request) { data, _,error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(Events.self, from: data)
                    completion(.success(result.events))
                } catch {
                    print(String(describing: error))
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func getArticles(endpoint: Endpoints, date: String, completion: @escaping (Result<[Articles.Article], Error>) -> ())  {
        let url = URL(string: "https://site.api.espn.com/apis/site/v2/sports/")!
        let final = url.appendingPathComponent(endpoint.buildNews())
        var components = URLComponents(url: final, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "dates", value: date),
        ]
        let request = URLRequest(url: components.url!)
        let task = URLSession.shared.dataTask(with: request) { data, _,error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(Articles.self, from: data)
                    completion(.success(result.articles))
                } catch {
                    print(String(describing: error))
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func getHeader(id: String, sport: String, league: String, completion: @escaping (Result<Summary.Header, Error>) -> ())  {
        let url = URL(string: "https://site.api.espn.com/apis/site/v2/sports/\(sport)/\(league)/summary?event=\(id)")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _,error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(Summary.self, from: data)
                    completion(.success(result.header))
                } catch {
                    print(String(describing: error))
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func getBoxscore(id: String, sport: String, league: String, completion: @escaping (Result<Summary.Boxscore, Error>) -> ())  {
        let url = URL(string: "https://site.api.espn.com/apis/site/v2/sports/\(sport)/\(league)/summary?event=\(id)")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _,error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(Summary.self, from: data)
                    completion(.success(result.boxscore))
                } catch {
                    print(String(describing: error))
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func getInjury(id: String, sport: String, league: String, completion: @escaping (Result<[Summary.Injury], Error>) -> ())  {
        let url = URL(string: "https://site.api.espn.com/apis/site/v2/sports/\(sport)/\(league)/summary?event=\(id)")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _,error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(Summary.self, from: data)
                    completion(.success(result.injuries ?? []))
                } catch {
                    print(String(describing: error))
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func getSeries(id: String, sport: String, league: String, completion: @escaping (Result<[Summary.SeasonSeries], Error>) -> ())  {
        let url = URL(string: "https://site.api.espn.com/apis/site/v2/sports/\(sport)/\(league)/summary?event=\(id)")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _,error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(Summary.self, from: data)
                    completion(.success(result.seasonseries))
                } catch {
                    print(String(describing: error))
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

//
//  AwayBoxScoreViewController.swift
//  FinalProject
//
//  Created by Michael Gillund on 3/1/23.
//

import UIKit

class AwayBoxScoreViewController: UIViewController {
    
    private let networkManager = NetworkManager()
    
    var id: String = ""
    var sport: String = ""
    var pre: Bool = false
    var live: Bool = false
    var post: Bool = false
    
    var boxscore: Summary.Boxscore? = nil
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(BoxscoreTableViewCell.self, forCellReuseIdentifier: "AwayBoxscoreTableViewCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        setupLayout()
        
        fetch()
        
    }
    func setupLayout() {
        view.addSubview(tableView)
        tableView.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor
        )
    }
    
    func fetch() {
        var sportType: (sport: String, league: String)
        switch self.sport {
        case "nfl":
            sportType = ("football", "nfl")
        case "nba":
            sportType = ("basketball", "nba")
        case "mlb":
            sportType = ("baseball", "mlb")
        case "nhl":
            sportType = ("hockey", "nhl")
        default:
            return
        }
    
        networkManager.getBoxscore(id: self.id, sport: sportType.sport, league: sportType.league, completion: { result in
            switch result {
            case .success(let boxscore):
                DispatchQueue.main.async {
                    self.boxscore = boxscore
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })

    }
}

extension AwayBoxScoreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
                
        switch self.sport {
        case "nba":
            return 2
        case "mlb":
            return 2
        case "nhl":
            return 3
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch self.sport {
        case "nba":
            if section == 0 {
                return boxscore?.starterAway.count ?? 0
            }else {
                return boxscore?.benchAway.count ?? 0
            }
        default:
            return boxscore?.players?[0].statistics?[section].athletes?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch self.sport {
        case "nfl":
            return boxscore?.statAway[section].type ?? ""
        case "nba":
            if section == 0 {
                return "Starter"
            }else {
                return "Bench"
            }
        case "mlb":
            return boxscore?.statAway[section].type ?? ""
        case "nhl":
            return boxscore?.statAway[section].name ?? ""
        default:
            return boxscore?.statAway[section].type ?? ""
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AwayBoxscoreTableViewCell", for: indexPath) as! BoxscoreTableViewCell
        
        
        if let stats = boxscore?.players?[0].statistics{
            if self.sport == "nba"{
                cell.setStatistic(statistic: stats[0], index: indexPath, sport: self.sport, live: self.live)
            }else{
                cell.setStatistic(statistic: stats[indexPath.section], index: indexPath, sport: self.sport, live: self.live)
            }
        }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
        
    }
}

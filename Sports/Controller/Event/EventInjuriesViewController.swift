//
//  EventInjuriesViewController.swift
//  FinalProject
//
//  Created by Michael Gillund on 3/1/23.
//

import UIKit

class EventInjuriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let networkManager = NetworkManager()
    
    var id: String = ""
    var sport: String = ""

    var injury: [Summary.Injury] = []
    
    private var count = 0
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(InjuryTableViewCell.self, forCellReuseIdentifier: "InjuryTableViewCell")
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
        networkManager.getInjury(id: self.id, sport: sportType.sport, league: sportType.league, completion: { result in
            switch result {
            case .success(let injury):
                DispatchQueue.main.async {
                    self.injury = injury.filter { $0.injuries?.isEmpty == false }
                    self.count = self.injury.count
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return injury.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return injury[section].injuries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return injury[section].team?.abbreviation ?? ""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InjuryTableViewCell", for: indexPath) as! InjuryTableViewCell
        cell.setInjury(injury: injury[indexPath.section].injuries?[indexPath.row], sport: self.sport)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
        
    }
    
}

//
//  EventMatchupViewController.swift
//  FinalProject
//
//  Created by Michael Gillund on 2/27/23.
//

import UIKit

class EventMatchupViewController: UIViewController {
    
    private let networkManager = NetworkManager()
    
    var id: String = ""
    var sport: String = ""
    var header: Summary.Header? = nil
    var series: Summary.SeasonSeries? = nil
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MatchupTableViewCell.self, forCellReuseIdentifier: "MatchupTableViewCell")
        tableView.register(LinescoreTableViewCell.self, forCellReuseIdentifier: "LinescoreTableViewCell")
        tableView.register(SeriesTableViewCell.self, forCellReuseIdentifier: "SeriesTableViewCell")
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
        networkManager.getHeader(id: self.id, sport: sportType.sport, league: sportType.league, completion: { result in
            switch result {
            case .success(let header):
                DispatchQueue.main.async {
                    self.header = header
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        networkManager.getSeries(id: self.id, sport: sportType.sport, league: sportType.league, completion: { result in
            switch result {
            case .success(let series):
                DispatchQueue.main.async {
                    self.series = series.first
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })

    }

}

extension EventMatchupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            let pre = header?.pre ?? false
            if !pre {
                return 2
            }else{
                return 1
            }
        case 1:
            return series?.events?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return header?.gametime ?? ""
        case 1:
            return series?.title ?? ""
        default:
            return ""
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let detail = EventDetailViewController()
            if let series = series?.events?[indexPath.row] {
                detail.id = series.id ?? ""
                detail.sport = series.league 
                detail.pre = series.pre
                detail.live = series.live
                detail.post = series.post

            }
            if let sheet = detail.sheetPresentationController {
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 30
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            }
            present(detail, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                if let header = header {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "MatchupTableViewCell", for: indexPath) as! MatchupTableViewCell
                    cell.setHeader(header: header)
                    cell.backgroundColor = .clear
                    cell.selectionStyle = .none
                    return cell
                }
            case 1:
                if let header = header {
                    if !header.pre {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "LinescoreTableViewCell", for: indexPath) as! LinescoreTableViewCell
                        cell.setHeader(header: header)
                        cell.backgroundColor = .clear
                        cell.selectionStyle = .none
                        return cell
                    }
                }
            default:
                break
            }
        case 1:
            if let event = series?.events?[indexPath.row] {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SeriesTableViewCell", for: indexPath) as! SeriesTableViewCell
                cell.setEvent(event: event)
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
                return cell
            }
        default:
            break
        }
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
}

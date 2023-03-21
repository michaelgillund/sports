//
//  EventViewController.swift
//  FinalProject
//
//  Created by Michael Gillund on 2/16/23.
//

import UIKit
import SwiftUI

class EventViewController: UIViewController {
    
    private let networkManager = NetworkManager()
    
    var date: Date = Date()
    private var sections: [EventSections] = []

    let tableView = UITableView(frame: .zero, style: .grouped)
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        setupTableView()
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "EventTableViewCell")
        tableView.backgroundColor = .systemBackground
        tableView.refreshControl = refreshControl
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 78, left: 0, bottom: 0, right: 0)

        fetch()

    }
    
    func setupTableView() {
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        circleButton(button: button, color: .systemBlue)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        view.addSubview(button)
        button.anchor(
            top: nil,
            leading: nil,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.safeAreaLayoutGuide.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 30, right: 30),
            size: .init(width: 60, height: 60)
        )
    }
    
    func fetch() {
        var fetched = [EventSections]()

        let group = DispatchGroup()

        let endpoints: [Endpoints] = [.nfl, .nba, .mlb, .nhl]

        for endpoint in endpoints {
            group.enter()
            networkManager.getEvents(endpoint: endpoint, date: date.query(), completion: { result in
                switch result {
                case .success(let event):
                    DispatchQueue.main.async {
                        if !event.isEmpty {
                            let section = EventSections(title: endpoint.path, sports: event)
                            fetched.append(section)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                group.leave()
            })
        }

        group.notify(queue: .main) {
            let order = ["NFL", "NBA", "MLB", "NHL"]
            let unsorted = fetched

            let sorted = unsorted.sorted { first, second in
                guard let firstIndex = order.firstIndex(of: first.title),
                      let secondIndex = order.firstIndex(of: second.title) else {
                    return false
                }
                
                return firstIndex < secondIndex
            }
            
            self.sections = sorted
            self.tableView.reloadData()
        }
    }
    
    @objc private func refresh(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.fetch()
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc func buttonTapped() {
        
        hapticImpactLight()

        let menu = UIAlertController(title: "Edit Date", message: "Choose a new date", preferredStyle: .actionSheet)

        menu.addAction(UIAlertAction(title: "Yesterday", style: .default, handler: { _ in
            self.date = Calendar.current.date(byAdding: .day, value: -1, to: self.date)!
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.fetch()
                self.tableView.reloadData()
            }
        }))

        menu.addAction(UIAlertAction(title: "Tommorow", style: .default, handler: { _ in
            self.date = Calendar.current.date(byAdding: .day, value: 1, to: self.date)!
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.fetch()
                self.tableView.reloadData()
            }
        }))

        menu.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        menu.modalPresentationStyle = .popover
        let popover = menu.popoverPresentationController
        popover?.sourceView = view

        present(menu, animated: true, completion: nil)
    }
    
    func circleButton(button : UIButton, color: UIColor){
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.backgroundColor = color
        button.tintColor = .white
        button.setImage(UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(weight: .black)), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .black)

    }
    
}

extension EventViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return sections.count
     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].sports.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        hapticImpactLight()
        
        let detail = EventDetailViewController()
        
        let event = sortEvent(section: indexPath.section, row: indexPath.row)
        
        print(event.id)
        
        detail.id = event.id
        detail.sport = event.league
        detail.pre = event.pre
        detail.live = event.live
        detail.post = event.post
        
        if let sheet = detail.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }

        present(detail, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = EventTableViewHeader(title: sections[section].title)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
        let event = sortEvent(section: indexPath.section, row: indexPath.row)
        cell.setEvent(event: event)

        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        return cell
    }
 
    func sortEvent(section: Int, row: Int) -> Events.Event {
        let sorted = sections[section].sports.sorted(by: {$0.sorted < $1.sorted})
        let event = sorted[row]
        return event
    }
}

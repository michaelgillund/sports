//
//  NewsViewController.swift
//  FinalProject
//
//  Created by Michael Gillund on 2/23/23.
//

import UIKit
import SafariServices

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let networkManager = NetworkManager()
    var date: Date = Date()
    var articles: [Articles.Article] = []
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        setupTableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        tableView.backgroundColor = .systemBackground
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 78, left: 0, bottom: 0, right: 0)

        
        fetch()
    }
    
    func setupTableView() {
      view.addSubview(tableView)
      tableView.translatesAutoresizingMaskIntoConstraints = false
      tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func fetch() {
        var fetched = [Articles.Article]()

        let group = DispatchGroup()

        let endpoints: [Endpoints] = [.nfl, .nba, .mlb, .nhl]

        for endpoint in endpoints {
            group.enter()
            networkManager.getArticles(endpoint: endpoint, date: date.query(), completion: { result in
                switch result {
                case .success(let article):
                    DispatchQueue.main.async {
                        if !article.isEmpty {
                            fetched.append(contentsOf: article.filter({$0.type != "Preview" && $0.type != "Recap"}))
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                group.leave()
            })
        }

        group.notify(queue: .main) {
            self.articles = fetched.sorted(by: {$0.published ?? "" > $1.published ?? ""})
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = NewsTableViewHeader(title: "Top Headlines")
        return view
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        hapticImpactLight()
        showArticle(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.setNews(article: articles[indexPath.row])
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        return cell
    }
    
    func showArticle(_ index: Int) {
        
        if let url = URL(string: "\(articles[index].links?.mobile?.href ?? "\(articles[index].links?.web?.href ?? "")")") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            vc.modalPresentationStyle = .pageSheet
            if let sheet = vc.sheetPresentationController {
                sheet.preferredCornerRadius = 30
                sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            }
            
            present(vc, animated: true)
        }
    }

}

//
//  EventBoxscoreViewController.swift
//  FinalProject
//
//  Created by Michael Gillund on 2/28/23.
//

import UIKit

class EventBoxScoreViewController: UIViewController {
    
    var id: String = ""
    var sport: String = ""
    var pre: Bool = false
    var live: Bool = false
    var post: Bool = false
    
    private let titles = ["Away", "Home"]
    private lazy var items = {
        return [self.awayBoxscore, self.homeBoxscore]
    }()
    
    var awayBoxscore: AwayBoxScoreViewController = AwayBoxScoreViewController()
    var homeBoxscore: HomeBoxScoreViewController = HomeBoxScoreViewController()
    
    var selectedIndex: Int = 0 { didSet { headerCollectionView.reloadData() }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupLayout()
        
        headerCollectionView.register(DetailHeaderCell.self, forCellWithReuseIdentifier: "DetailHeaderCell")
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
        headerCollectionView.allowsSelection = true
        headerCollectionView.backgroundColor = .clear
        
        pagerCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerCollectionView.delegate = self
        pagerCollectionView.dataSource = self
        pagerCollectionView.isPagingEnabled = false
        pagerCollectionView.showsHorizontalScrollIndicator = false
        pagerCollectionView.isScrollEnabled = false
        
        selectedIndex = 0

        awayBoxscore.id = self.id
        awayBoxscore.sport = self.sport
        awayBoxscore.pre = self.pre
        awayBoxscore.live = self.live
        awayBoxscore.post = self.post
        
        homeBoxscore.id = self.id
        homeBoxscore.sport = self.sport
        homeBoxscore.pre = self.pre
        homeBoxscore.live = self.live
        homeBoxscore.post = self.post

    }

    func setupLayout(){
        
        view.addSubview(indicatorBackground)
        indicatorBackground.addSubview(indicator)
        indicatorBackground.addSubview(headerCollectionView)
        view.addSubview(pagerCollectionView)
        
        indicatorBackground.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: pagerCollectionView.topAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 20, left: 64, bottom: 10, right: 64),
            size: .init(width: 0, height: 50)
        )
        
        indicator.anchor(
            top: indicatorBackground.topAnchor,
            leading: indicatorBackground.leadingAnchor,
            bottom: indicatorBackground.bottomAnchor,
            trailing: nil,
            padding: .init(top: 5, left: 5, bottom: 5, right: 0)
        )
        indicator.widthAnchor.constraint(equalTo: indicatorBackground.widthAnchor, multiplier: 0.5, constant: -10).isActive = true
        
        headerCollectionView.anchor(
            top: indicatorBackground.topAnchor,
            leading: indicatorBackground.leadingAnchor,
            bottom: indicatorBackground.bottomAnchor,
            trailing: indicatorBackground.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 50)
        )
        
        pagerCollectionView.anchor(
            top: indicatorBackground.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 10, left: 0, bottom: 0, right: 0)
        )
    }
    
    let headerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    let pagerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    let indicator: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 20
        v.layer.cornerCurve = .continuous
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.08
        v.layer.shadowRadius = 6
        v.layer.shadowOffset = CGSize(width: 0, height: 2)
        return v
    }()
    let indicatorBackground: UIView = {
        let v = UIView()
        v.backgroundColor = .secondarySystemBackground
        v.layer.cornerRadius = 25
        v.layer.cornerCurve = .continuous
        return v
    }()
}


extension EventBoxScoreViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x: CGFloat = scrollView.contentOffset.x
        let sw: CGFloat = scrollView.frame.width
        let pct: CGFloat = x / sw
        
        let iw: CGFloat = indicator.frame.width + 10
        let offset: CGFloat = iw * pct

        indicator.transform = CGAffineTransform(translationX: offset, y: 0)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let item = x / view.frame.width
        let indexPath = IndexPath(item: Int(item), section: 0)
        headerCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        selectedIndex = indexPath.item

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == headerCollectionView {
            return titles.count
        }
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == headerCollectionView {
            pagerCollectionView.scrollToItem(
                at: IndexPath(item: indexPath.item, section: 0),
                at: .centeredHorizontally,
                animated: true
            )
            selectedIndex = indexPath.item
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == headerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailHeaderCell", for: indexPath) as! DetailHeaderCell
            cell.label.text = titles[indexPath.item]
            cell.label.textColor = indexPath.item == selectedIndex ? .black : .lightGray
            cell.backgroundColor = .clear
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let vc = items[indexPath.row]
        
        cell.addSubview(vc.view)
        
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        vc.view.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
        vc.view.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
        vc.view.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == headerCollectionView {
            let width = indicatorBackground.frame.width
            return .init(width: width / CGFloat(titles.count), height: indicatorBackground.frame.height)
        }
        let width = view.frame.width
        return .init(width: width, height: pagerCollectionView.frame.height)
    }
}


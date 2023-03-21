//
//  EventDetailViewController.swift
//  FinalProject
//
//  Created by Michael Gillund on 2/26/23.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    private lazy var items: [UIViewController] = []
    private var titles: [String] = []
    
    var id: String = ""
    var sport: String = ""
    var pre: Bool = false
    var live: Bool = false
    var post: Bool = false
    
    var matchup: EventMatchupViewController = EventMatchupViewController()
    var boxscore: EventBoxScoreViewController = EventBoxScoreViewController()
    var injuries: EventInjuriesViewController = EventInjuriesViewController()
    
    var selectedIndex: Int = 0 { didSet { headerCollectionView.reloadData() } }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.pagerCollectionView.scrollToItem(at: IndexPath(row: self.selectedIndex, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        self.addChild(matchup)
        self.addChild(boxscore)
        self.addChild(injuries)
        
        if pre{
            titles = ["Matchup", "Injuries"]
            items = [self.matchup, self.injuries]
            selectedIndex = 0
        }else if live{
            titles = ["Matchup", "Boxscore"]
            items = [self.matchup, self.boxscore]
            selectedIndex = 0
        }else if post{
            titles = ["Matchup", "Boxscore"]
            items = [self.matchup, self.boxscore]
            selectedIndex = 0
        }
        
        setupLayout()
        
        headerCollectionView.register(DetailHeaderCell.self, forCellWithReuseIdentifier: "DetailHeaderCell")
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
        headerCollectionView.allowsSelection = true
        
        pagerCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerCollectionView.delegate = self
        pagerCollectionView.dataSource = self
        pagerCollectionView.isPagingEnabled = true
        pagerCollectionView.showsHorizontalScrollIndicator = false

        
        matchup.id = self.id
        matchup.sport = self.sport
        
        boxscore.id = self.id
        boxscore.sport = self.sport
        boxscore.pre = self.pre
        boxscore.live = self.live
        boxscore.post = self.post
        
        injuries.id = self.id
        injuries.sport = self.sport
    }
    
    func setupLayout(){
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        circleButton(button: button, color: .systemBlue)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)


        view.addSubview(headerCollectionView)
        view.addSubview(pagerCollectionView)
        view.addSubview(indicator)
        view.addSubview(button)
        
        button.anchor(
            top: nil,
            leading: nil,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.safeAreaLayoutGuide.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 30, right: 30),
            size: .init(width: 60, height: 60)
        )
        headerCollectionView.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: pagerCollectionView.topAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 20, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 80)
        )
        indicator.anchor(
            top: nil,
            leading: view.leadingAnchor,
            bottom: headerCollectionView.bottomAnchor,
            trailing: nil,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0),
            size: .init(width: view.frame.width / CGFloat(titles.count), height: 4)
        )
        pagerCollectionView.anchor(
            top: headerCollectionView.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0)
        )
    }
    
    @objc func buttonTapped() {
        dismiss(animated: true)
    }
    
    func circleButton(button : UIButton, color: UIColor){
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.backgroundColor = color
        button.tintColor = .white
        button.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(weight: .black)), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .black)
        
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
        v.layer.cornerRadius = 2
        v.layer.cornerCurve = .continuous
        return v
    }()
}

extension EventDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x: CGFloat = scrollView.contentOffset.x
        let sw: CGFloat = scrollView.frame.width
        let pct: CGFloat = x / sw
        
        let iw: CGFloat = indicator.frame.width
        let offset: CGFloat = iw * pct

        indicator.transform = CGAffineTransform(translationX: offset, y: 0)
        
        let contentOffset = scrollView.contentOffset
        if contentOffset.x < 0 {
            scrollView.contentOffset.x = 0
        }
        if contentOffset.x > scrollView.contentSize.width - scrollView.frame.width {
            scrollView.contentOffset.x = scrollView.contentSize.width - scrollView.frame.width
        }
        
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
            pagerCollectionView.isPagingEnabled = false
            pagerCollectionView.scrollToItem(
                at: IndexPath(item: indexPath.item, section: 0),
                at: .centeredHorizontally,
                animated: true
            )
            pagerCollectionView.isPagingEnabled = true
            selectedIndex = indexPath.item
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == headerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailHeaderCell", for: indexPath) as! DetailHeaderCell
            cell.label.text = titles[indexPath.item]
            cell.label.textColor = indexPath.item == selectedIndex ? .label : .lightGray
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
            let width = view.frame.width
            return .init(width: width / CGFloat(titles.count), height: 80)
        }
        let width = view.frame.width
        return .init(width: width, height: pagerCollectionView.frame.height)
    }
}

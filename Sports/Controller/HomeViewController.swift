//
//  HomeViewController.swift
//  FinalProject
//
//  Created by Michael Gillund on 3/5/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var items: [UIViewController] = []
    private var titles: [String] = []

    private lazy var eventViewController = EventViewController()
    private lazy var newsViewController = NewsViewController()

    private var selectedIndex: Int = 0 { didSet { headerCollectionView.reloadData() }}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        self.addChild(self.eventViewController)
        self.addChild(self.newsViewController)
        
        titles = ["Today", "News"]
        items = [self.eventViewController, self.newsViewController]
        
        setupLayout()
        
        headerCollectionView.register(HeaderCell.self, forCellWithReuseIdentifier: "HeaderCell")
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
        headerCollectionView.allowsSelection = true
        headerCollectionView.isScrollEnabled = false
        headerCollectionView.showsHorizontalScrollIndicator = false
        
        pagerCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerCollectionView.delegate = self
        pagerCollectionView.dataSource = self
        pagerCollectionView.isPagingEnabled = true
        pagerCollectionView.showsHorizontalScrollIndicator = false
        
        selectedIndex = 0

    }
    
    func setupLayout(){
        
        view.addSubview(pagerCollectionView)
        view.addSubview(statusView)
        view.addSubview(container)
        
        container.addSubview(visualEffectView)
        container.addSubview(indicator)
        container.addSubview(headerCollectionView)
    
        statusView.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            size: .init(width: 0, height: statusBarHeight())
        )
        container.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 10 , left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 68)
        )
        visualEffectView.anchor(
            top: container.topAnchor,
            leading: container.leadingAnchor,
            bottom: container.bottomAnchor,
            trailing: container.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0)
        )
        
        indicator.anchor(
            top: container.topAnchor,
            leading: container.leadingAnchor,
            bottom: container.bottomAnchor,
            trailing: nil,
            padding: .init(top: 5, left: 5, bottom: 5, right: 0)
        )
        indicator.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.5, constant: -10).isActive = true
        
        headerCollectionView.anchor(
            top: container.topAnchor,
            leading: container.leadingAnchor,
            bottom: container.bottomAnchor,
            trailing: container.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 68)
        )
        
        pagerCollectionView.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0)
        )
    }
    
    func statusBarHeight() -> Int {
        var value = 0
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let statusBarManager = windowScene.statusBarManager {
            let statusBarHeight = statusBarManager.statusBarFrame.size.height
            value = Int(statusBarHeight)
        }
        return value
    }
    
    let headerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
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
        v.layer.cornerRadius = 29
        v.layer.cornerCurve = .continuous
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.08
        v.layer.shadowRadius = 6
        v.layer.shadowOffset = CGSize(width: 0, height: 2)
        return v
    }()
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let view = UIVisualEffectView(effect: blurEffect)
        view.layer.cornerRadius = 34
        view.layer.cornerCurve = .continuous
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var statusView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let container: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.layer.cornerRadius = 34
        v.layer.cornerCurve = .continuous
        return v
    }()

}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x: CGFloat = scrollView.contentOffset.x
        let sw: CGFloat = scrollView.frame.width
        let pct: CGFloat = x / sw

        let iw: CGFloat = indicator.frame.width + 10
        let offset: CGFloat = iw * pct

        if offset < 0 {
            indicator.transform = CGAffineTransform(translationX: 0, y: 0)
        } else if offset > iw {
            indicator.transform = CGAffineTransform(translationX: iw, y: 0)
        } else {
            indicator.transform = CGAffineTransform(translationX: offset, y: 0)
        }
        
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
            hapticImpactLight()
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            cell.label.text = titles[indexPath.item]
            cell.label.textColor = indexPath.item == selectedIndex ? .black : .lightGray
            return cell
        }
        let cell = pagerCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
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
            let width = container.frame.width
            return .init(width: width / CGFloat(titles.count), height: 68)
        }
        let width = view.frame.width
        return .init(width: width, height: pagerCollectionView.frame.height)
    }
}

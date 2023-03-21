//
//  CollectionPager.swift
//  FinalProject
//
//  Created by Michael Gillund on 2/20/23.
//

//import UIKit
//
//class CollectionPager: UICollectionViewController, UICollectionViewDelegateFlowLayout, CollectionDelegate {
//
//    var eventViewController: EventViewController = EventViewController()
//    var newsViewController: NewsViewController = NewsViewController()
//    
//    private lazy var items = {
//        return [self.eventViewController, self.newsViewController]
//    }()
//    
//    fileprivate let collectionHeader = CollectionHeader(collectionViewLayout: UICollectionViewFlowLayout())
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.addChild(DatePickerViewController())
//        self.addChild(self.eventViewController)
//        self.addChild(self.newsViewController)
//        
//        view.backgroundColor = .systemBackground
//        collectionHeader.delegate = self
//        collectionHeader.collectionView.selectItem(at: [0,0], animated: true, scrollPosition: .centeredHorizontally)
//        
//        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.scrollDirection = .horizontal
//            layout.minimumLineSpacing = 0
//        }
//        
//        setupLayout()
//        
//        collectionView.delegate = self
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        collectionView.isPagingEnabled = true
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.allowsSelection = true
//
//    }
//
//    fileprivate func setupLayout(){
//        
//        view.addSubview(indicatorBackground)
//        indicatorBackground.addSubview(indicator)
//        indicatorBackground.addSubview(collectionHeader.view)
//        
//        indicatorBackground.anchor(
//            top: view.safeAreaLayoutGuide.topAnchor,
//            leading: view.leadingAnchor,
//            bottom: collectionView.topAnchor,
//            trailing: view.trailingAnchor,
//            padding: .init(top: 0, left: 16, bottom: 10, right: 16),
//            size: .init(width: 0, height: 68)
//        )
//        
//        indicator.anchor(
//            top: indicatorBackground.topAnchor,
//            leading: indicatorBackground.leadingAnchor,
//            bottom: indicatorBackground.bottomAnchor,
//            trailing: nil,
//            padding: .init(top: 5, left: 5, bottom: 5, right: 0)
//        )
//        indicator.widthAnchor.constraint(equalTo: indicatorBackground.widthAnchor, multiplier: 0.5, constant: -10).isActive = true
//        
//        collectionHeader.view.anchor(
//            top: indicatorBackground.topAnchor,
//            leading: indicatorBackground.leadingAnchor,
//            bottom: indicatorBackground.bottomAnchor,
//            trailing: indicatorBackground.trailingAnchor,
//            padding: .init(top: 0, left: 0, bottom: 0, right: 0),
//            size: .init(width: 0, height: 68)
//        )
//        
//        collectionView.anchor(
//            top: indicatorBackground.bottomAnchor,
//            leading: view.leadingAnchor,
//            bottom: view.bottomAnchor,
//            trailing: view.trailingAnchor,
//            padding: .init(top: 10, left: 0, bottom: 0, right: 0)
//        )
//    }
//    
//    func didTapHeaderCell(index: Int) {
//        collectionView.isPagingEnabled = false
//        collectionView.scrollToItem(
//            at: IndexPath(item: index, section: 0),
//            at: .centeredHorizontally,
//            animated: true
//        )
//        collectionView.isPagingEnabled = true
//    }
//    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let x: CGFloat = scrollView.contentOffset.x
//        let sw: CGFloat = scrollView.frame.width
//        let pct: CGFloat = x / sw
//        
//        let iw: CGFloat = indicator.frame.width + 10
//        let offset: CGFloat = iw * pct
//
//        indicator.transform = CGAffineTransform(translationX: offset, y: 0)
//    }
//
//    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let x = targetContentOffset.pointee.x
//        let item = x / view.frame.width
//        let indexPath = IndexPath(item: Int(item), section: 0)
//        collectionHeader.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
//        collectionHeader.selectedIndex = indexPath.item
//
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return items.count
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        let vc = items[indexPath.row]
//        
//        cell.addSubview(vc.view)
//        
//        vc.view.translatesAutoresizingMaskIntoConstraints = false
//        vc.view.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
//        vc.view.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
//        vc.view.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
//        vc.view.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let height = collectionView.frame.height
//        let width = view.frame.width
//        return .init(width: width, height: height)
//    }
//    
//    let indicator: UIView = {
//        let v = UIView()
//        v.backgroundColor = .white
//        v.layer.cornerRadius = 29
//        v.layer.cornerCurve = .continuous
//        v.layer.shadowColor = UIColor.black.cgColor
//        v.layer.shadowOpacity = 0.08
//        v.layer.shadowRadius = 6
//        v.layer.shadowOffset = CGSize(width: 0, height: 2)
//        return v
//    }()
//
//    let indicatorBackground: UIView = {
//        let v = UIView()
//        v.backgroundColor = .secondarySystemBackground
//        v.layer.cornerRadius = 34
//        v.layer.cornerCurve = .continuous
//        return v
//    }()
//}

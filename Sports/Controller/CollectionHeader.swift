//
//  CollectionHeader.swift
//  FinalProject
//
//  Created by Michael Gillund on 2/20/23.
//

//import UIKit

//protocol CollectionDelegate {
//    
//    func didTapHeaderCell(index: Int)
//}
//
//class CollectionHeader: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//    
//    fileprivate let titles = ["Today", "News"]
//    
//    var delegate: CollectionDelegate?
//
//    var selectedIndex: Int = 0 {
//        didSet {
//            collectionView.reloadData()
//        }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        collectionView.backgroundColor = .clear
//        collectionView.layer.cornerRadius = 30
//        
//        collectionView.register(HeaderCell.self, forCellWithReuseIdentifier: "HeaderCell")
//        
//        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.scrollDirection = .horizontal
//            layout.minimumLineSpacing = 0
//            layout.minimumInteritemSpacing = 0
//        }
//        selectedIndex = 0
//    }
//    
//    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.didTapHeaderCell(index: indexPath.item)
//        selectedIndex = indexPath.item
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        
//        return titles.count
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
//        cell.label.text = titles[indexPath.item]
//        cell.label.textColor = indexPath.item == selectedIndex ? .black : .lightGray
//        cell.filterButton.layer.opacity = indexPath.item == selectedIndex ? 1 : 0
//        if indexPath.item == 0 {
//            cell.filterButton.isHidden = false
//        } else {
//            cell.filterButton.isHidden = true
//        }
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let width = view.frame.width
//        return .init(width: width / 2, height: view.frame.height)
//    }
//    
//}


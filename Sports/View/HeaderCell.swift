//
//  HeaderCell.swift
//  FinalProject
//
//  Created by Michael Gillund on 3/13/23.
//

import UIKit

class HeaderCell: UICollectionViewCell {

    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? .black : .lightGray
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let label: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .lightGray
        l.font = .systemFont(ofSize: 18, weight: .bold)
        return l
    }()
}

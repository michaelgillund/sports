//
//  EventTableViewHeader.swift
//  FinalProject
//
//  Created by Michael Gillund on 2/24/23.
//

import UIKit

class EventTableViewHeader: UIView {

    init(title: String) {
        super.init(frame: .zero)
        
        let view = UIView()
        
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        
        addSubview(view)
        view.addSubview(label)
        view.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
        label.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 16, left: 16, bottom: 8, right: 16)
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

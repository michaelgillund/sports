//
//  InjuryTableViewHeader.swift
//  FinalProject
//
//  Created by Michael Gillund on 3/1/23.
//

import UIKit
import SDWebImage

class InjuryTableViewHeader: UIView {

    init(title: String, url: String) {
        super.init(frame: .zero)
        
        let view = UIView()
        
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .lightGray
        
        addSubview(view)
        view.addSubview(label)
        view.addSubview(image)
        view.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
        image.sd_setImage(with: URL(string: url))
        image.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: nil,
            padding: .init(top: 16, left: 16, bottom: 8, right: 0),
            size: .init(width: 30, height: 30)
        )
        label.anchor(
            top: view.topAnchor,
            leading: image.trailingAnchor,
            bottom: view.bottomAnchor,
            trailing: nil,
            padding: .init(top: 16, left: 10, bottom: 8, right: 0)
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let image: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
}

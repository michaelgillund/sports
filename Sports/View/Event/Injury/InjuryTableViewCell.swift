//
//  InjuryTableViewCell.swift
//  FinalProject
//
//  Created by Michael Gillund on 3/1/23.
//

import UIKit
import SDWebImage

class InjuryTableViewCell: UITableViewCell {
    
    func setInjury(injury: Summary.Injury.Injury?, sport: String) {

        name.text = injury?.athlete?.displayName ?? ""
        if sport == "nba" {
            status.text = "\(injury?.details?.fantasyStatus?.abbreviation ?? "") - \(injury?.details?.type ?? "")"
        }else {
            status.text = injury?.status?.capitalized
        }
        position.text = injury?.athlete?.position?.abbreviation ?? ""
        
        if self.traitCollection.userInterfaceStyle == .dark {
            if let urlString = injury?.athlete?.headshot?.href, let url = URL(string: urlString) {
                image.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
            }
        } else {
            if let urlString = injury?.athlete?.headshot?.href, let url = URL(string: urlString) {
                image.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    private func setupLayout() {

        let view = UIView()
        
        view.backgroundColor = .secondarySystemGroupedBackground
        
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 25
        view.layer.cornerCurve = .continuous
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowOpacity = 0.06
        view.layer.shadowRadius = 12
        
        contentView.addSubview(view)
        view.addSubview(image)
        view.addSubview(name)
        view.addSubview(position)
        view.addSubview(status)

        view.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            padding: .init(top: 4, left: 16, bottom: 8, right: 16)
        )
        image.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: nil,
            padding: .init(top: 16, left: 16, bottom: 16, right: 0),
            size: .init(width: 60, height: 60)
        )
        name.anchor(
            top: view.topAnchor,
            leading: image.trailingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 16, left: 10, bottom: 0, right: 0),
            size: .init(width: 0, height: 30)
        )
        status.anchor(
            top: name.bottomAnchor,
            leading: image.trailingAnchor,
            bottom: view.bottomAnchor,
            trailing: nil,
            padding: .init(top: 0, left: 10, bottom: 16, right: 0),
            size: .init(width: 0, height: 30)
        )
        position.anchor(
            top: view.topAnchor,
            leading: nil,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 16, left: 0, bottom: 0, right: 16)
        )
        
    }
    
    let image: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .black
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 30
        iv.layer.cornerCurve = .circular
        iv.layer.masksToBounds = true
        return iv
    }()
    let name: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .label
        l.font = .systemFont(ofSize: 16, weight: .bold)
        return l
    }()
    let position: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .lightGray
        l.font = .systemFont(ofSize: 12, weight: .regular)
        return l
    }()
    let status: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .lightGray
        l.font = .systemFont(ofSize: 14, weight: .regular)
        return l
    }()
}


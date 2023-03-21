//
//  EventTableViewCell.swift
//  FinalProject
//
//  Created by Michael Gillund on 2/23/23.
//

import UIKit
import SDWebImage

class EventTableViewCell: UITableViewCell {
    
    func setEvent(event: Events.Event) {
        
        gametime.text = event.gametime
        homeName.text = event.homeName
        homeScore.text = event.homeScore
        awayName.text = event.awayName
        awayScore.text = event.awayScore
        
        if self.traitCollection.userInterfaceStyle == .dark {
            if let homeImageUrl = URL(string: event.homeImageDark) {
                homeImageView.sd_setImage(with: homeImageUrl, placeholderImage: UIImage(named: "placeholder.png"))
            }
            if let awayImageUrl = URL(string: event.awayImageDark) {
                awayImageView.sd_setImage(with: awayImageUrl, placeholderImage: UIImage(named: "placeholder.png"))
            }
        } else {
            if let homeImageUrl = URL(string: event.homeImage) {
                homeImageView.sd_setImage(with: homeImageUrl, placeholderImage: UIImage(named: "placeholder.png"))
            }
            if let awayImageUrl = URL(string: event.awayImage) {
                awayImageView.sd_setImage(with: awayImageUrl, placeholderImage: UIImage(named: "placeholder.png"))
            }
        }
        
        gametime.textColor = true == event.live ? .systemRed : .lightGray
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
        view.addSubview(gametime)
        view.addSubview(homeImageView)
        view.addSubview(homeName)
        view.addSubview(homeScore)
        view.addSubview(awayImageView)
        view.addSubview(awayName)
        view.addSubview(awayScore)
        
        view.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            padding: .init(top: 4, left: 16, bottom: 8, right: 16)
        )
        gametime.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 0)
        )
        awayImageView.anchor(
            top: gametime.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: homeImageView.topAnchor,
            trailing: awayName.leadingAnchor,
            padding: .init(top: 6, left: 16, bottom: 6, right: 10),
            size: .init(width: 35, height: 35)
        )
        awayName.anchor(
            top: gametime.bottomAnchor,
            leading: nil,
            bottom: homeName.topAnchor,
            trailing: nil,
            padding: .init(top: 6, left: 0, bottom: 6, right: 0),
            size: .init(width: 0, height: 35)
        )
        awayScore.anchor(
            top: nil,
            leading: nil,
            bottom: homeScore.topAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 6, right: 16),
            size: .init(width: 0, height: 35)
        )
        homeImageView.anchor(
            top: awayImageView.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: homeName.leadingAnchor,
            padding: .init(top: 6, left: 16, bottom: 16, right: 10),
            size: .init(width: 35, height: 35)
        )
        homeName.anchor(
            top: awayName.bottomAnchor,
            leading: nil,
            bottom: view.bottomAnchor,
            trailing: nil,
            padding: .init(top: 6, left: 0, bottom: 16, right: 0),
            size: .init(width: 0, height: 35)
        )
        homeScore.anchor(
            top: awayScore.bottomAnchor,
            leading: nil,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 6, left: 0, bottom: 16, right: 16),
            size: .init(width: 0, height: 35)
        )
    }
    
    let gametime: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .lightGray
        l.font = .systemFont(ofSize: 13, weight: .regular)
        return l
    }()
    let homeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
     }()
    let homeName: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .label
        l.font = .systemFont(ofSize: 17, weight: .heavy)
        return l
    }()
    let homeScore: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .label
        l.font = .systemFont(ofSize: 17, weight: .heavy)
        return l
    }()
    let awayImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
     }()
    let awayName: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .label
        l.font = .systemFont(ofSize: 17, weight: .heavy)
        return l
    }()
    let awayScore: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .label
        l.font = .systemFont(ofSize: 17, weight: .heavy)
        return l
    }()
}


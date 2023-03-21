//
//  MatchupTableViewCell.swift
//  FinalProject
//
//  Created by Michael Gillund on 2/27/23.
//

import UIKit
import SDWebImage

class MatchupTableViewCell: UITableViewCell {
    
    func setHeader(header: Summary.Header) {
        
        homeName.text = header.homeName
        homeScore.text = header.homeScore
        homeAbv.text = header.homeAbv
        homeRecord.text = header.homeRecord
        
        awayName.text = header.awayName
        awayScore.text = header.awayScore
        awayAbv.text = header.awayAbv
        awayRecord.text = header.awayRecord
        
        if self.traitCollection.userInterfaceStyle == .dark {
            if let homeImageUrl = URL(string: header.homeImageDark) {
                homeImageView.sd_setImage(with: homeImageUrl, placeholderImage: UIImage(named: "placeholder.png"))
            }
            if let awayImageUrl = URL(string: header.awayImageDark) {
                awayImageView.sd_setImage(with: awayImageUrl, placeholderImage: UIImage(named: "placeholder.png"))
            }
        } else {
            if let homeImageUrl = URL(string: header.homeImage) {
                homeImageView.sd_setImage(with: homeImageUrl, placeholderImage: UIImage(named: "placeholder.png"))
            }
            if let awayImageUrl = URL(string: header.awayImage) {
                awayImageView.sd_setImage(with: awayImageUrl, placeholderImage: UIImage(named: "placeholder.png"))
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
        view.addSubview(homeImageView)
        view.addSubview(homeScore)
        view.addSubview(awayImageView)
        view.addSubview(awayScore)
        
        
    
        let awaystackView = UIStackView(arrangedSubviews: [awayAbv, awayName, awayRecord])
        awaystackView.axis = .vertical
        awaystackView.alignment = .leading
        awaystackView.distribution = .fillEqually
        awaystackView.spacing = 0
        
        view.addSubview(awaystackView)
 
        let homestackView = UIStackView(arrangedSubviews: [homeAbv, homeName, homeRecord])
        homestackView.axis = .vertical
        homestackView.alignment = .leading
        homestackView.distribution = .fillEqually
        homestackView.spacing = 0
        
        view.addSubview(homestackView)
        
        view.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            padding: .init(top: 4, left: 16, bottom: 8, right: 16)
        )
        awayImageView.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: homeImageView.topAnchor,
            trailing: awaystackView.leadingAnchor,
            padding: .init(top: 16, left: 16, bottom: 6, right: 10),
            size: .init(width: 60, height: 60)
        )
        awaystackView.anchor(
            top: view.topAnchor,
            leading: nil,
            bottom: homestackView.topAnchor,
            trailing: nil,
            padding: .init(top: 16, left: 0, bottom: 6, right: 0),
            size: .init(width: 0, height: 60)
        )
        awayScore.anchor(
            top: view.topAnchor,
            leading: nil,
            bottom: homeScore.topAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 16, left: 0, bottom: 6, right: 16),
            size: .init(width: 0, height: 60)
        )
        homeImageView.anchor(
            top: awayImageView.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: homestackView.leadingAnchor,
            padding: .init(top: 6, left: 16, bottom: 16, right: 10),
            size: .init(width: 60, height: 60)
        )
        homestackView.anchor(
            top: awaystackView.bottomAnchor,
            leading: nil,
            bottom: view.bottomAnchor,
            trailing: nil,
            padding: .init(top: 6, left: 0, bottom: 16, right: 0),
            size: .init(width: 0, height: 60)
        )
        homeScore.anchor(
            top: awayScore.bottomAnchor,
            leading: nil,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 6, left: 0, bottom: 16, right: 16),
            size: .init(width: 0, height: 60)
        )
    }
    let homeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
     }()
    let homeAbv: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .lightGray
        l.font = .systemFont(ofSize: 12, weight: .regular)
        return l
    }()
    let homeName: UILabel = {
        let l = UILabel()
        l.numberOfLines = 2
        l.textAlignment = .center
        l.textColor = .label
        l.font = .systemFont(ofSize: 22, weight: .bold)
        return l
    }()
    let homeRecord: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .lightGray
        l.font = .systemFont(ofSize: 10, weight: .regular)
        return l
    }()
    let homeScore: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .label
        l.font = .systemFont(ofSize: 32, weight: .bold)
        return l
    }()
    let awayImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
     }()
    let awayAbv: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .lightGray
        l.font = .systemFont(ofSize: 12, weight: .regular)
        return l
    }()
    let awayRecord: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .lightGray
        l.font = .systemFont(ofSize: 10, weight: .regular)
        return l
    }()
    let awayName: UILabel = {
        let l = UILabel()
        l.numberOfLines = 2
        l.textAlignment = .center
        l.textColor = .label
        l.font = .systemFont(ofSize: 22, weight: .bold)
        return l
    }()
    let awayScore: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .label
        l.font = .systemFont(ofSize: 34, weight: .bold)
        return l
    }()
}

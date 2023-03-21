//
//  BoxscoreTableViewCell.swift
//  FinalProject
//
//  Created by Michael Gillund on 3/1/23.
//

import UIKit
import SDWebImage

class BoxscoreTableViewCell: UITableViewCell {

    func setStatistic(statistic: Summary.Boxscore.Player.Statistic, index: IndexPath, sport: String, live: Bool) {
        for subview in statStackView.arrangedSubviews {
            statStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        for subview in labelStackView.arrangedSubviews {
            labelStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        switch sport {
        case "nfl":
            break
        case "nba":
                
                if index.section == 0 {
                    if var athletes = statistic.athletes?.filter({ $0.starter == true}) {
                        athletes.sort(by: {
                            let x = Int($0.min)
                            let y = Int($1.min)

                            return x ?? 0 > y ?? 0
                        })
                        if let headshotHref = athletes[index.row].athlete?.headshot?.href, let imageUrl = URL(string: headshotHref) {
                            image.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder.png"))
                        }
                        name.text = athletes[index.row].athlete?.displayName ?? ""
                        position.text = athletes[index.row].athlete?.position?.abbreviation ?? ""
                        
                        let nbaStat = athletes[index.row].nbaStats
                        let nbaLabel = statistic.nbaLabels
                        
                        min.text = athletes[index.row].min
                        minLabel.text = "MIN"
                     
                        
                        if let isActive = athletes[index.row].active {
                            if live {
                                nbaInGame.backgroundColor = true == isActive ? .systemBlue : .clear
                            }
                        }
                        
                        if !nbaStat.isEmpty {
                            for stat in nbaStat {
                                let label = UILabel()
                                label.text = stat
                                label.textAlignment = .center
                                label.font = .systemFont(ofSize: 14, weight: .regular)
                                label.textColor = .label
                                label.translatesAutoresizingMaskIntoConstraints = false
                                statStackView.addArrangedSubview(label)
                            }
                            
                            for stat in nbaLabel {
                                let label = UILabel()
                                label.text = stat
                                label.textAlignment = .center
                                label.font = .systemFont(ofSize: 12, weight: .regular)
                                label.textColor = .lightGray
                                label.translatesAutoresizingMaskIntoConstraints = false
                                labelStackView.addArrangedSubview(label)
                            }
                        }
                    }
                }else {
                    if var athletes = statistic.athletes?.filter({ $0.starter == false}) {
                        athletes.sort(by: {
                            let x = Int($0.min)
                            let y = Int($1.min)

                            return x ?? 0 > y ?? 0
                        })
                        if let headshotHref = athletes[index.row].athlete?.headshot?.href, let imageUrl = URL(string: headshotHref) {
                            image.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder.png"))
                        }
                        name.text = athletes[index.row].athlete?.displayName ?? ""
                        position.text = athletes[index.row].athlete?.position?.abbreviation ?? ""
                        let nbaStat = athletes[index.row].nbaStats
                        let nbaLabel = statistic.nbaLabels
                        
                        min.text = athletes[index.row].min
                        minLabel.text = "MIN"
                        
                      
                        if let isActive = athletes[index.row].active {
                            if live {
                                nbaInGame.backgroundColor = true == isActive ? .systemBlue : .clear
                            }
                        }
                    
                        if !nbaStat.isEmpty {
                            for stat in nbaStat {
                                let label = UILabel()
                                label.text = stat
                                label.textAlignment = .center
                                label.font = .systemFont(ofSize: 14, weight: .regular)
                                label.textColor = .label
                                label.translatesAutoresizingMaskIntoConstraints = false
                                statStackView.addArrangedSubview(label)
                            }
                            
                            for stat in nbaLabel {
                                let label = UILabel()
                                label.text = stat
                                label.textAlignment = .center
                                label.font = .systemFont(ofSize: 12, weight: .regular)
                                label.textColor = .lightGray
                                label.translatesAutoresizingMaskIntoConstraints = false
                                labelStackView.addArrangedSubview(label)
                            }
                        }
                    }
                }

        case "mlb":
            if let athletes = statistic.athletes {
                if let headshotHref = athletes[index.row].athlete?.headshot?.href, let imageUrl = URL(string: headshotHref) {
                    
                    let placeholderImage = UIImage(named: "placeholder.png")
                    let errorImage = UIImage(systemName: "wifi.exclamationmark")
                    errorImage?.withTintColor(.systemRed)
                    
                    image.sd_setImage(with: imageUrl, placeholderImage: placeholderImage, options: .preloadAllFrames, completed: { (image, error, cacheType, url) in
                        if error != nil {
                            self.image.image = errorImage
                        }
                    })
                    
                }

                name.text = athletes[index.row].athlete?.displayName ?? ""
                position.text = athletes[index.row].athlete?.position?.abbreviation ?? ""
                
                if index.section == 0 {
                    
                    let mlbBattingStats = athletes[index.row].mlbBattingStats
                    let mlbBattingLabels = statistic.mlbBattingLabels
                    if !mlbBattingStats.isEmpty {
                        for stat in mlbBattingStats {
                            let label = UILabel()
                            label.text = stat
                            label.textAlignment = .center
                            label.font = .systemFont(ofSize: 14, weight: .regular)
                            label.textColor = .label
                            label.translatesAutoresizingMaskIntoConstraints = false
                            statStackView.addArrangedSubview(label)
                        }
                        
                        for stat in mlbBattingLabels {
                            let label = UILabel()
                            label.text = stat
                            label.textAlignment = .center
                            label.font = .systemFont(ofSize: 12, weight: .regular)
                            label.textColor = .lightGray
                            label.translatesAutoresizingMaskIntoConstraints = false
                            labelStackView.addArrangedSubview(label)
                        }
                    }
                }else {
                    
                    let mlbPitchingStats = athletes[index.row].mlbPitchingStats
                    let mlbPitchingLabels = statistic.mlbPitchingLabels
                    if !mlbPitchingStats.isEmpty {
                        for stat in mlbPitchingStats {
                            let label = UILabel()
                            label.text = stat
                            label.textAlignment = .center
                            label.font = .systemFont(ofSize: 14, weight: .regular)
                            label.textColor = .label
                            label.translatesAutoresizingMaskIntoConstraints = false
                            statStackView.addArrangedSubview(label)
                        }
                        
                        for stat in mlbPitchingLabels {
                            let label = UILabel()
                            label.text = stat
                            label.textAlignment = .center
                            label.font = .systemFont(ofSize: 12, weight: .regular)
                            label.textColor = .lightGray
                            label.translatesAutoresizingMaskIntoConstraints = false
                            labelStackView.addArrangedSubview(label)
                        }
                    }
                }
            }
        case "nhl":
            if let athletes = statistic.athletes {
                if let headshotHref = athletes[index.row].athlete?.headshot?.href, let imageUrl = URL(string: headshotHref) {
                    image.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder.png"))
                }
                name.text = athletes[index.row].athlete?.displayName ?? ""
                position.text = athletes[index.row].athlete?.position?.abbreviation ?? ""
                if index.section == 0 || index.section == 1{
                    let nhlForDefStats = athletes[index.row].nhlForDefStats
                    let nhlForDefLabels = statistic.nhlForDefLabels
                    if !nhlForDefStats.isEmpty {
                        for stat in nhlForDefStats {
                            let label = UILabel()
                            label.text = stat
                            label.textAlignment = .center
                            label.font = .systemFont(ofSize: 14, weight: .regular)
                            label.textColor = .label
                            label.translatesAutoresizingMaskIntoConstraints = false
                            statStackView.addArrangedSubview(label)
                        }
                        
                        for stat in nhlForDefLabels {
                            let label = UILabel()
                            label.text = stat
                            label.textAlignment = .center
                            label.font = .systemFont(ofSize: 12, weight: .regular)
                            label.textColor = .lightGray
                            label.translatesAutoresizingMaskIntoConstraints = false
                            labelStackView.addArrangedSubview(label)
                        }
                    }
                }else{
                    let nhlGoalieStats = athletes[index.row].nhlGoalieStats
                    let nhlGoalieLabels = statistic.nhlGoalieLabels
                    if !nhlGoalieStats.isEmpty {
                        for stat in nhlGoalieStats {
                            let label = UILabel()
                            label.text = stat
                            label.textAlignment = .center
                            label.font = .systemFont(ofSize: 14, weight: .regular)
                            label.textColor = .label
                            label.translatesAutoresizingMaskIntoConstraints = false
                            statStackView.addArrangedSubview(label)
                        }
                        
                        for stat in nhlGoalieLabels {
                            let label = UILabel()
                            label.text = stat
                            label.textAlignment = .center
                            label.font = .systemFont(ofSize: 12, weight: .regular)
                            label.textColor = .lightGray
                            label.translatesAutoresizingMaskIntoConstraints = false
                            labelStackView.addArrangedSubview(label)
                        }
                    }
                }
            }
        default:
            break
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
    let nbaInGame: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.layer.cornerCurve = .continuous
        view.clipsToBounds = true
        return view
    }()
    
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
        
        statStackView.axis = .horizontal
        statStackView.alignment = .center
        statStackView.distribution = .fillEqually
        statStackView.spacing = 0
        
        labelStackView.axis = .horizontal
        labelStackView.alignment = .center
        labelStackView.distribution = .fillEqually
        labelStackView.spacing = 0
        
        contentView.addSubview(view)
        view.addSubview(nbaInGame)
        view.addSubview(image)
        view.addSubview(name)
        view.addSubview(position)
        view.addSubview(min)
        view.addSubview(statStackView)
        view.addSubview(labelStackView)
        view.addSubview(minLabel)
        
        view.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            padding: .init(top: 4, left: 16, bottom: 8, right: 16)
        )
        nbaInGame.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: nil,
            padding: .init(top: 36, left: 0, bottom: 36, right: 0),
            size: .init(width: 4, height: 0)
        )
        image.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: name.leadingAnchor,
            padding: .init(top: 16, left: 16, bottom: 16, right: 10),
            size: .init(width: 60, height: 60)
        )
        name.anchor(
            top: view.topAnchor,
            leading: image.trailingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 16, left: 10, bottom: 0, right: 0)
        )
        position.anchor(
            top: view.topAnchor,
            leading: name.trailingAnchor,
            bottom: statStackView.topAnchor,
            trailing: nil,
            padding: .init(top: 16, left: 10, bottom: 10, right: 0)
        )
        min.anchor(
            top: view.topAnchor,
            leading: nil,
            bottom: statStackView.topAnchor,
            trailing: minLabel.leadingAnchor,
            padding: .init(top: 16, left: 0, bottom: 10, right: 4)
        )
        minLabel.anchor(
            top: view.topAnchor,
            leading: nil,
            bottom: statStackView.topAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 16, left: 0, bottom: 10, right: 16)
        )
        statStackView.anchor(
            top: name.bottomAnchor,
            leading: image.trailingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 10, left: 10, bottom: 0, right: 16)
        )
        labelStackView.anchor(
            top: statStackView.bottomAnchor,
            leading: image.trailingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 2, left: 10, bottom: 16, right: 16)
        )
    }
    let statStackView = UIStackView()
    let labelStackView = UIStackView()
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
    let min: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .label
        l.font = .systemFont(ofSize: 12, weight: .regular)
        return l
    }()
    let minLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .lightGray
        l.font = .systemFont(ofSize: 12, weight: .regular)
        return l
    }()
 
}

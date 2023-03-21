//
//  LinescoreTableViewCell.swift
//  FinalProject
//
//  Created by Michael Gillund on 2/27/23.
//

import UIKit
import SDWebImage

class LinescoreTableViewCell: UITableViewCell {

    
    func setHeader(header: Summary.Header) {

        homeAbv.text = header.homeAbv
        awayAbv.text = header.awayAbv
        
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
        
        for subview in legendStackView.arrangedSubviews {
            legendStackView.removeArrangedSubview(subview)
             subview.removeFromSuperview()
         }
         
         for subview in awayStackView.arrangedSubviews {
             awayStackView.removeArrangedSubview(subview)
             subview.removeFromSuperview()
         }
        for subview in homeStackView.arrangedSubviews {
            homeStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        let count = header.awayLinescore.count
        for legend in 0..<count {
            let label = UILabel()
            label.text = "\(legend +  1)"
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 14, weight: .regular)
            label.textColor = .lightGray
            label.translatesAutoresizingMaskIntoConstraints = false
            label.widthAnchor.constraint(equalToConstant: 25).isActive = true
            label.heightAnchor.constraint(equalToConstant: 30).isActive = true
            legendStackView.addArrangedSubview(label)
        }
        if !header.pre{
            let t = UILabel()
            t.text = "T"
            t.textAlignment = .center
            t.font = .systemFont(ofSize: 14, weight: .regular)
            t.textColor = .lightGray
            t.translatesAutoresizingMaskIntoConstraints = false
            t.widthAnchor.constraint(equalToConstant: 25).isActive = true
            t.heightAnchor.constraint(equalToConstant: 30).isActive = true
            legendStackView.addArrangedSubview(t)
        }
        
        var awayTotal = 0
        for away in header.awayLinescore {
            awayTotal = awayTotal + (Int(away.displayValue ?? "") ?? 0)
            let label = UILabel()
            label.text = away.displayValue ?? ""
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 14, weight: .regular)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.widthAnchor.constraint(equalToConstant: 25).isActive = true
            label.heightAnchor.constraint(equalToConstant: 30).isActive = true
            awayStackView.addArrangedSubview(label)
        }
        if !header.pre{
            let a = UILabel()
            a.text = "\(awayTotal)"
            a.textAlignment = .center
            a.font = .systemFont(ofSize: 14, weight: .regular)
            a.translatesAutoresizingMaskIntoConstraints = false
            a.widthAnchor.constraint(equalToConstant: 25).isActive = true
            a.heightAnchor.constraint(equalToConstant: 30).isActive = true
            awayStackView.addArrangedSubview(a)
        }
        
        var homeTotal = 0
        for home in header.homeLinescore {
            homeTotal = homeTotal + (Int(home.displayValue ?? "") ?? 0)
            let label = UILabel()
            label.text = home.displayValue ?? ""
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 14, weight: .regular)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.widthAnchor.constraint(equalToConstant: 25).isActive = true
            label.heightAnchor.constraint(equalToConstant: 30).isActive = true
            homeStackView.addArrangedSubview(label)
        }
        if header.league?.slug == "mlb" && header.awayLinescore.count != header.homeLinescore.count {
            let x = UILabel()
            x.text = "-"
            x.textAlignment = .center
            x.font = .systemFont(ofSize: 14, weight: .regular)
            x.translatesAutoresizingMaskIntoConstraints = false
            x.widthAnchor.constraint(equalToConstant: 25).isActive = true
            x.heightAnchor.constraint(equalToConstant: 30).isActive = true
            homeStackView.addArrangedSubview(x)
        }
        if !header.pre{
            let h = UILabel()
            h.text = "\(homeTotal)"
            h.textAlignment = .center
            h.font = .systemFont(ofSize: 14, weight: .regular)
            h.translatesAutoresizingMaskIntoConstraints = false
            h.widthAnchor.constraint(equalToConstant: 25).isActive = true
            h.heightAnchor.constraint(equalToConstant: 30).isActive = true
            homeStackView.addArrangedSubview(h)
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
 
        legendStackView.axis = .horizontal
        legendStackView.alignment = .leading
        legendStackView.distribution = .fillEqually
        legendStackView.spacing = 0

        homeStackView.axis = .horizontal
        homeStackView.alignment = .leading
        homeStackView.distribution = .fillEqually
        homeStackView.spacing = 0

        awayStackView.axis = .horizontal
        awayStackView.alignment = .leading
        awayStackView.distribution = .fillEqually
        awayStackView.spacing = 0
        
        scoring.text = "Scoring"
        
        contentView.addSubview(view)
        view.addSubview(scoring)
        view.addSubview(homeImageView)
        view.addSubview(homeAbv)
        view.addSubview(awayImageView)
        view.addSubview(awayAbv)
        view.addSubview(legendStackView)
        view.addSubview(awayStackView)
        view.addSubview(homeStackView)
    

        
        view.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            padding: .init(top: 4, left: 16, bottom: 8, right: 16)
        )
        
        scoring.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: awayImageView.topAnchor,
            trailing: nil,
            padding: .init(top: 16, left: 16, bottom: 8, right: 0)
        )
        awayImageView.anchor(
            top: scoring.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: homeImageView.topAnchor,
            trailing: awayAbv.leadingAnchor,
            padding: .init(top: 8, left: 16, bottom: 8, right: 8),
            size: .init(width: 30, height: 30)
        )
        awayAbv.anchor(
            top: scoring.bottomAnchor,
            leading: awayImageView.trailingAnchor,
            bottom: homeAbv.topAnchor,
            trailing: nil,
            padding: .init(top: 8, left: 8, bottom: 8, right: 0),
            size: .init(width: 0, height: 30)
        )
        homeImageView.anchor(
            top: awayImageView.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: homeAbv.leadingAnchor,
            padding: .init(top: 8, left: 16, bottom: 16, right: 8),
            size: .init(width: 30, height: 30)
        )
        homeAbv.anchor(
            top: awayAbv.bottomAnchor,
            leading: homeImageView.trailingAnchor,
            bottom: view.bottomAnchor,
            trailing: nil,
            padding: .init(top: 8, left: 8, bottom: 16, right: 0),
            size: .init(width: 0, height: 30)
        )
        legendStackView.anchor(
            top: view.topAnchor,
            leading: nil,
            bottom: awayStackView.topAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 16, left: 0, bottom: 8, right: 16)
        )
        awayStackView.anchor(
            top: legendStackView.bottomAnchor,
            leading: nil,
            bottom: homeStackView.topAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 8, left: 0, bottom: 8, right: 16)
        )
        homeStackView.anchor(
            top: awayStackView.bottomAnchor,
            leading: nil,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 8, left: 0, bottom: 16, right: 16)
        )
    }
    
    let legendStackView = UIStackView()
    
    let homeStackView = UIStackView()
    
    let awayStackView = UIStackView()
    
    let scoring: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .label
        l.font = .systemFont(ofSize: 16, weight: .bold)
        return l
    }()
    let homeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
     }()
    let homeAbv: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .label
        l.font = .systemFont(ofSize: 14, weight: .regular)
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
        l.textColor = .label
        l.font = .systemFont(ofSize: 14, weight: .regular)
        return l
    }()

}

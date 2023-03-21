//
//  NewsTableViewCell.swift
//  FinalProject
//
//  Created by Michael Gillund on 2/24/23.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {
    
    func setNews(article: Articles.Article) {
        
        let images = article.images?.first
        if let image = images {
            if let urlString = image.url, let url = URL(string: urlString) {

                self.image.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
            }
        }
        headline.text = article.headline
        
        let string = article.published ?? ""
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let value = formatter.date(from: string) {
            let secondsAgo = Int(Date().timeIntervalSince(value))
            let minutesAgo = secondsAgo / 60
            let hoursAgo = minutesAgo / 60
            
            if hoursAgo > 0 {
                date.text = "\(hoursAgo) hr ago"
            } else {
                date.text = "\(minutesAgo) min ago"
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
        view.addSubview(headline)
        view.addSubview(date)
       
        view.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            padding: .init(top: 4, left: 16, bottom: 8, right: 16)
        )
        
        image.anchor(
            top: view.topAnchor,
            leading: headline.trailingAnchor,
            bottom: date.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 16, left: 16, bottom: 16, right: 16),
            size: .init(width: 100, height: 100)
        )
        
        headline.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: image.leadingAnchor,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )
        
        date.anchor(
            top: nil,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 16, bottom: 16, right: 16),
            size: .init(width: 0, height: 20)
        )
       
    }
    
    let image: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.cornerCurve = .continuous
        iv.clipsToBounds = true
        return iv
     }()
    
    let headline: UILabel = {
        let l = UILabel()
        l.textColor = .label
        l.font = .systemFont(ofSize: 17, weight: .bold)
        l.numberOfLines = 0
        l.sizeToFit()
        return l
    }()
    
    let date: UILabel = {
        let l = UILabel()
        l.textAlignment = .left
        l.textColor = .lightGray
        l.font = .systemFont(ofSize: 12, weight: .regular)
        return l
    }()
    
}


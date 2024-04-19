//
//  NewsCell.swift
//  ImediNews
//
//  Created by Default on 19.04.24.
//

import UIKit

class NewsCell: UITableViewCell {
    
    let  newsImageView: UIImageView = {
        let news = UIImageView()
        news.translatesAutoresizingMaskIntoConstraints = false
        news.backgroundColor = UIColor.red
        news.contentMode = .scaleAspectFit
        news.clipsToBounds = true
        return news
    }()
    
    let timeOfNew: UILabel = {
        let tm = UILabel()
        tm.translatesAutoresizingMaskIntoConstraints = false
        return tm
    }()
    
    let titleOfNew: UILabel = {
        let tl = UILabel()
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.numberOfLines = 0
        return tl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constraintForCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with newsItem: imediNewsModel) {
           titleOfNew.text = newsItem.Title
           timeOfNew.text = newsItem.Time
           
           if let photoUrl = newsItem.PhotoUrl {
               DispatchQueue.global().async {
                   if let imageData = try? Data(contentsOf: photoUrl) {
                       DispatchQueue.main.async {
                           self.newsImageView.image = UIImage(data: imageData)
                       }
                   }
               }
           } else {
               self.newsImageView.image = UIImage(named: "Image")
           }
       }
    
    func constraintForCell() {
        contentView.addSubview(newsImageView)
        newsImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        newsImageView.heightAnchor.constraint(equalToConstant: 108).isActive = true
        newsImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15).isActive = true
        newsImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 25).isActive = true
        newsImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15).isActive = true
        newsImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -25).isActive = true
        newsImageView.layer.cornerRadius = 30
        
        newsImageView.addSubview(timeOfNew)
        timeOfNew.widthAnchor.constraint(equalToConstant: 70).isActive = true
        timeOfNew.heightAnchor.constraint(equalToConstant: 14).isActive = true
        timeOfNew.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 40).isActive = true
        timeOfNew.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        timeOfNew.font = UIFont(name: "FiraGO", size: 12)
        timeOfNew.textAlignment = .center
        timeOfNew.numberOfLines = 0
        
        newsImageView.addSubview(titleOfNew)
        titleOfNew.widthAnchor.constraint(equalToConstant: 303).isActive = true
        titleOfNew.heightAnchor.constraint(equalToConstant: 100).isActive = true
        titleOfNew.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant: 40).isActive = true
        titleOfNew.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 41).isActive = true
        titleOfNew.font = UIFont(name: "FiraGO", size: 14)
        titleOfNew.textColor = UIColor.white
        
    }
}



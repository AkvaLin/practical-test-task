//
//  AdvertisementCell.swift
//  PracticalTestTask
//
//  Created by Никита Пивоваров on 25.08.2023.
//

import UIKit

class AdvertisementCell: UICollectionViewCell {
    
    static let reuseID = String(describing: AdvertisementCell.self)
    
    private let imageView: CustomImageView = {
        let view = CustomImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        lbl.numberOfLines = 2
        return lbl
    }()
    private let priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        return lbl
    }()
    private let locationLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 10, weight: .thin)
        return lbl
    }()
    private let createdDateLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 10, weight: .thin)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(createdDateLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 5,
                                 y: 0,
                                 width: contentView.frame.size.width - 10,
                                 height: contentView.frame.size.width - 10)
        titleLabel.frame = CGRect(x: 5,
                                  y: contentView.frame.size.height / 100 * 65,
                                  width: contentView.frame.size.width - 10,
                                  height: contentView.frame.size.height / 100 * 16)
        priceLabel.frame = CGRect(x: 5,
                                  y: contentView.frame.size.height / 100 * 81.5,
                                  width: contentView.frame.size.width - 10,
                                  height: contentView.frame.size.height / 100 * 8)
        locationLabel.frame = CGRect(x: 5,
                                     y: contentView.frame.size.height / 100 * 90,
                                     width: contentView.frame.size.width - 10,
                                     height: contentView.frame.size.height / 100 * 5)
        createdDateLabel.frame = CGRect(x: 5,
                                        y: contentView.frame.size.height / 100 * 95,
                                        width: contentView.frame.size.width - 10,
                                        height: contentView.frame.size.height / 100 * 5)
    }
    
    public func configure(imageURL: URL?, title: String, price: String, location: String, date: String) {
        imageView.loadImage(from: imageURL)
        titleLabel.text = title
        priceLabel.text = price
        locationLabel.text = location
        createdDateLabel.text = date
    }
}

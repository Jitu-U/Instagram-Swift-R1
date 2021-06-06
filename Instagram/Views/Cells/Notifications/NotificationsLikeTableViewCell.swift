//
//  NotificationsLikeTableViewCell.swift
//  Instagram
//
//  Created by Jitesh gamit on 06/06/21.
//


import SDWebImage
import UIKit

protocol NotificationsLikeTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(model: userNotification)
}

class NotificationsLikeTableViewCell: UITableViewCell {
    static let identifier = "NotificationsLikeTableViewCell"
    
    private var model: userNotification?

    weak var delegate: NotificationsLikeTableViewCellDelegate?
    
    private let profilePicView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .cyan
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@Jitu.171 liked your profile Picture"
        return label
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "test"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profilePicView)
        contentView.addSubview(label)
        contentView.addSubview(postButton)
        postButton.addTarget(self,
                             action: #selector(didTapPostButton),
                             for: .touchUpInside)
    }
    
    @objc private func didTapPostButton(){
        guard let model = model else {
            return
        }
        delegate?.didTapRelatedPostButton(model: model)
    }
    
    public func configure(with model: userNotification){
        self.model = model
        switch model.type {
        case .like(let post):
            let thumbnail = post.thumbnailImage
            guard !thumbnail.absoluteString.contains("google.com") else {
                return
            }
            postButton.sd_setImage(with: thumbnail,
                                   for: .normal,
                                   completed: nil)
        case .follow:
            break
        }
        label.text = model.text
        profilePicView.sd_setImage(with: model.user.profilePicture, completed: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postButton.setBackgroundImage(nil, for: .normal)
        label.text = nil
        profilePicView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Photo , text, Post Butoon
        profilePicView.frame = CGRect(x: 5, y: 5, width: contentView.height - 10, height: contentView.height-10)
        profilePicView.layer.cornerRadius = profilePicView.height/2
        
        postButton.frame = CGRect(x: contentView.width - contentView.height-8, y: 2, width: contentView.height-8, height: contentView.height-8)
        label.frame = CGRect(x: profilePicView.right+13,
                             y: 0,
                             width: contentView.width-postButton.width-profilePicView.width-20,
                             height: contentView.height)
    }
}

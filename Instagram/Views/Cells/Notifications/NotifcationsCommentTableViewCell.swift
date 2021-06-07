//
//  NotifcationsCommentTableViewCell.swift
//  Instagram
//
//  Created by Jitesh gamit on 06/06/21.
//

import UIKit

protocol NotificationsCommentTableViewCellDelegate: AnyObject {
    func didTapLikeCommentButton(model: userNotification)
    func didTapReplyButton(model: userNotification)
}


class NotifcationsCommentTableViewCell: UITableViewCell {
    static let identifier = "NotificationsCommentTableViewCell"
    
    private var model: userNotification?

    weak var delegate: NotificationsCommentTableViewCellDelegate?
    
    private let profilePicView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .cyan
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "@arianagrande replied to your comment:"
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@Jitu.171 True That! "
        return label
    }()
    
    private let commentLike: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        button.clipsToBounds = true
        button.tintColor = .red
        return button
    }()
    
    private let replyButton: UIButton = {
        let button = UIButton()
        button.setTitle("reply", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profilePicView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(commentLike)
        contentView.addSubview(commentLabel)
        commentLike.addTarget(self,
                             action: #selector(didTapLikeCommentButton),
                             for: .touchUpInside)
        replyButton.addTarget(self,
                              action: #selector(didTapReplyButton),
                              for: .touchUpInside)
        
        selectionStyle = .none
    }
    
    @objc private func didTapLikeCommentButton(){
        guard let model = model else {
            return
        }
        commentLike.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        delegate?.didTapLikeCommentButton(model: model)
    }
    
    @objc private func didTapReplyButton(){
        guard let model = model else {
            return
        }
        delegate?.didTapReplyButton(model: model)
    }
    
    public func configure(with model: userNotification){
        self.model = model
        switch model.type {
        case .like(_):
            break
        case .follow:
            break
        case .comment(post: _, comment: let comment):
            // Might Add Post Thumbnail Later
            titleLabel.text = "@\(comment.username) commented on your post"
            commentLabel.text = comment.comment
            break
        }
        
        profilePicView.sd_setImage(with: model.user.profilePicture, completed: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        profilePicView.image = nil
        commentLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Photo , text, Post Butoon
        profilePicView.frame = CGRect(x: 5, y: 5, width: contentView.height - 10, height: contentView.height-10)
        profilePicView.layer.cornerRadius = profilePicView.height/2
        
        commentLike.frame = CGRect(x: contentView.width - contentView.height-8, y: 10, width: 20, height: 18)
        
        titleLabel.frame = CGRect(x: profilePicView.right+13,
                             y: 0,
                             width: contentView.width-100-profilePicView.width-20,
                             height: contentView.height/3)
        commentLabel.frame = CGRect(x: titleLabel.left,
                                    y: titleLabel.bottom,
                                    width: titleLabel.width,
                                    height: 2*(contentView.height/3))
        replyButton.frame = CGRect(x: commentLabel.left,
                                   y: titleLabel.bottom/2,
                                   width: 60,
                                   height: 40)
    }
    
}

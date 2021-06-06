//
//  NotificationsFollowerTableViewCell.swift
//  Instagram
//
//  Created by Jitesh gamit on 06/06/21.
//

import UIKit

protocol NotificationsFollowerTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: userNotification)
}

class NotificationsFollowerTableViewCell: UITableViewCell {
    static let identifier = "NotificationsFollowerTableViewCell"

    weak var delegate: NotificationsFollowerTableViewCellDelegate?
    
    private var model: userNotification?
    
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
        label.text = "@cristiano started following you."
        label.numberOfLines = 0
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profilePicView)
        contentView.addSubview(label)
        contentView.addSubview(followButton)
        followButton.addTarget(self,
                               action: #selector(didTapFollowButton),
                               for: .touchUpInside)
        selectionStyle = .none
        
        
    }
    
    @objc private func didTapFollowButton(){
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnfollowButton(model: model)
    }
    
    public func configure(with model: userNotification){
        self.model = model
        switch model.type {
        case .like(_):
            break
        case .follow(let state):
            //Configure Model
            switch state {
            case .following:
                //Show unfollow Button
                followButton.setTitle("unfollow", for: .normal)
                followButton.setTitleColor(.secondaryLabel, for: .normal)
                followButton.layer.borderWidth = 1
                followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
                followButton.layer.cornerRadius = 8
            case .not_following:
                //Show follow Button
                followButton.setTitle("follow", for: .normal)
                followButton.setTitleColor(.systemBlue, for: .normal)
            }
            break
        }
        label.text = model.text
        profilePicView.sd_setImage(with: model.user.profilePicture, completed: nil)
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        label.text = nil
        profilePicView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profilePicView.frame = CGRect(x: 5, y: 5, width: contentView.height - 10, height: contentView.height-10)
        profilePicView.layer.cornerRadius = profilePicView.height/2
        
        label.frame = CGRect(x: profilePicView.right+13,
                             y: 0,
                             width: contentView.width-profilePicView.width-120,
                             height: contentView.height)
        
        followButton.frame = CGRect(x: label.right, y: contentView.height/4, width: 100, height: contentView.height/2)
        
    }
}

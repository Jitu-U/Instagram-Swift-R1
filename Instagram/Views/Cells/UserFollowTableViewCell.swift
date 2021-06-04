//
//  UserFollowTableViewCell.swift
//  Instagram
//
//  Created by Jitesh gamit on 03/06/21.
//

import UIKit

protocol userFollowTableViewCellDelegate: AnyObject {
    func didTapfollowUnfollowButton(model: String)
}

class UserFollowTableViewCell: UITableViewCell {
    static let identifier = "UserFollowTableViewCell"
   
    var weakdelegate: userFollowTableViewCellDelegate?
    
    private let profilePicView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .cyan
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "jitu.171"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Jitesh Gamit"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1.0
        button.layer.borderColor = .init(red: 0, green: 0, blue: 0.9, alpha: 1)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 5.0
        button.setTitle("follow", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(profilePicView)
        contentView.addSubview(followButton)
    }
    
    public func configure(with model: String){
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profilePicView.image = nil
        usernameLabel.text = nil
        nameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
        profilePicView.frame = CGRect(x: 3,
                                      y: 3,
                                      width: contentView.height - 6,
                                      height: contentView.height-6)
        profilePicView.layer.cornerRadius = profilePicView.height/2
        
        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width/4
        
        followButton.frame = CGRect(x: contentView.width-5-buttonWidth,
                                    y: 10,
                                    width: buttonWidth,
                                    height: contentView.height-20)
        
        let labelHeight = (contentView.height/2)-5
        
        usernameLabel.frame = CGRect(x: profilePicView.right+10,
                                     y: 10,
                                     width: contentView.width-8-profilePicView.width-buttonWidth,
                                     height: labelHeight)
        nameLabel.frame = CGRect(x: profilePicView.right+10,
                                     y: usernameLabel.bottom,
                                     width: contentView.width-8-profilePicView.width-buttonWidth,
                                     height: labelHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

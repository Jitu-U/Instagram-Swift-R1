//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Instagram
//
//  Created by Jitesh gamit on 01/06/21.
//



import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidtapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView )
    func profileHeaderDidtapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView )
    func profileHeaderDidtapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView )
    func profileHeaderDidtapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView )
}

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
        static let identifier = "ProfileInfoHeaderCollectionReusableView"
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let  profilePhotoImageView: UIImageView = {
      let imageView = UIImageView()
        imageView.image = UIImage(named: "test")
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let  postsButton : UIButton = {
      let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let  followersButton : UIButton = {
      let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let  followingButton : UIButton = {
      let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let  editProfileButton : UIButton = {
      let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Edit Profile", for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.borderWidth = 0.3
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5.0
        button.layer.shadowRadius = 5.0
        return button
    }()
    
    private let nameLabel: UILabel = {
      let label = UILabel()
        label.text = "Jitesh Gamit"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let bioLabel: UILabel = {
      let label = UILabel()
        label.text = "This is first account \n on Jitu's Instagram"
        label.textColor = .label
        label.numberOfLines = 0 // Line Wrap
        return label
    }()
    
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addButtonActions()
        backgroundColor = .systemBackground
        clipsToBounds = true
    }
    
    private func addSubviews(){
         addSubview(profilePhotoImageView)
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(postsButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    
    private func addButtonActions(){
        followersButton.addTarget(self,
                                  action: #selector(didTapFollowersButton),
                                  for: .touchUpInside)
        followingButton.addTarget(self,
                                  action: #selector(didTapFollowingButton),
                                  for: .touchUpInside)
        editProfileButton.addTarget(self ,
                                  action: #selector(didTapEditProfileButton),
                                  for: .touchUpInside)
        postsButton.addTarget(self,
                                  action: #selector(didTapPostsButton),
                                  for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profilePhotoSize = width/4
        profilePhotoImageView.frame = CGRect(
            x: 5,
            y: 5,
            width: profilePhotoSize,
            height: profilePhotoSize).integral
        
        let buttonHeight = profilePhotoSize/2
        let countsButtonWidth = (width-10-profilePhotoSize)/3
        
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
        
        // Followers Follwing and Post button on profile

        postsButton.frame = CGRect(
            x: profilePhotoImageView.right,
            y: 10,
            width: countsButtonWidth,
            height: buttonHeight).integral
        
        
        followersButton.frame = CGRect(
            x: postsButton.right,
            y: 10,
            width: countsButtonWidth,
            height: buttonHeight).integral
        
        followingButton.frame = CGRect(
            x: followersButton.right,
            y: 10,
            width: countsButtonWidth,
            height: buttonHeight).integral
        
        nameLabel .frame = CGRect(
            x: 10,
            y: profilePhotoImageView.bottom + 5,
            width: width - 10,
            height: 50).integral
        
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        bioLabel .frame = CGRect(
            x: 10,
            y: nameLabel.bottom + 10,
            width: width - 10,
            height: bioLabelSize.height).integral
        
        editProfileButton .frame = CGRect(x: 20,
                                          y: bioLabel.bottom+20,
                                          width: width - 40, height: 50)
       
        
    }
    
    //MARK: - Actions
    
    @objc private func didTapFollowersButton(){
        delegate?.profileHeaderDidtapFollowersButton(self)
    }
    
    @objc private func didTapFollowingButton(){
        delegate?.profileHeaderDidtapFollowingButton(self)
    }
    
    @objc private func didTapPostsButton(){
        delegate?.profileHeaderDidtapPostsButton(self)
    }
    
    @objc private func didTapEditProfileButton(){
        delegate?.profileHeaderDidtapEditProfileButton(self)
    }
}

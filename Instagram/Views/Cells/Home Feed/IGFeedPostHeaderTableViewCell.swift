//
//  IGFeedPostHeaderTableViewCell.swift
//  Instagram
//
//  Created by Jitesh gamit on 31/05/21.
//

import SDWebImage
import UIKit

protocol IGFeedPostHeaderTableViewCellDelegate: AnyObject{
    func didTapMoreButton()
}

class IGFeedPostHeaderTableViewCell: UITableViewCell {
    static let identifier = "IGFeedPostHeaderTableViewCell"
    weak var delegate: IGFeedPostHeaderTableViewCellDelegate?
    
    let profilePicImagevView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let userLabel: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis" ), for: .normal)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profilePicImagevView)
        contentView.addSubview(userLabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self,
                             action: #selector(didTapButton),
                             for: .touchUpInside)
    }
    
    @objc private func didTapButton(){
        delegate?.didTapMoreButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: User){
        userLabel.setTitle(model.username, for: .normal)
        profilePicImagevView.sd_setImage(with: URL(string: "https://yt3.ggpht.com/ytc/AAUvwnjyKzvLyxW8YJV6nSRC71JFUikN6ICJn_v-53mz1Q=s900-c-k-c0x00ffffff-no-rj"), completed: nil)
       // profilePicImagevView.sd_setImage(with: model.profilePicture, completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.height - 6
        profilePicImagevView.frame = CGRect(x: 8, y: 8, width: size-10, height: size-10)
        profilePicImagevView.layer.cornerRadius = size/2
        
        moreButton.frame = CGRect(x: contentView.width-size-4, y: 5, width: size, height: size)
        userLabel.frame = CGRect(x: profilePicImagevView.right+10,
                                 y: 5, width: contentView.width-(size*2)-10,
                                 height: contentView.height-10)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userLabel.setTitle(nil, for: .normal)
        profilePicImagevView.image = nil
        
    }
   

}

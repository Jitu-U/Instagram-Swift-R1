//
//  IGFeedPostActionsTableViewCell.swift
//  Instagram
//
//  Created by Jitesh gamit on 31/05/21.
//

import UIKit

protocol  IGFeedPostActionsTableViewCellDelegate: AnyObject {
    func didTapLikeButton()
    func didTapCommentButton()
    func didTapSendButton()
}

class IGFeedPostActionsTableViewCell: UITableViewCell {
    static let identifier = "IGFeedPostActionsTableViewCell"
    weak var delegate: IGFeedPostActionsTableViewCellDelegate?
    
    private let likeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "message", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28, weight: .light))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "paperplane", withConfiguration: UIImage.SymbolConfiguration(pointSize: 27, weight: .light))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(sendButton)
        
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapLikeButton(){
        let image = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 27, weight: .light))
        likeButton.setImage(image, for: .normal)
        likeButton.tintColor = .systemPink
        delegate?.didTapLikeButton()
    }
    @objc private func didTapCommentButton(){
        delegate?.didTapSendButton()
    }
    @objc private func didTapSendButton(){
        delegate?.didTapCommentButton()
    }
    
    public func configure(with post: UserPost){
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.height-6
        likeButton.frame = CGRect(x: 10, y: 3, width: size, height: size)
        commentButton.frame = CGRect(x: likeButton.right+5, y: 3, width: size, height: size)
        sendButton.frame = CGRect(x: commentButton.right+5, y: 3, width: size, height: size)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        likeButton.tintColor = .label
        let image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light))
        likeButton.setImage(image, for: .normal)
        
    }

}

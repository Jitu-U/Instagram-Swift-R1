//
//  PotoCollectionViewCell.swift
//  Instagram
//
//  Created by Jitesh gamit on 31/05/21.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoCollectionViewCell"
    
    private let PhotoImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        PhotoImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        PhotoImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(PhotoImageView)
        contentView.clipsToBounds = true
        accessibilityLabel = "User Post Image"
        accessibilityHint = "Double Tap to Open Post "
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model:  UserPost){
       // let thumbnailURL = model.thumnailmage
        
    }
    
    public func configure(debug imageName: String){
        // PhotoImageView.image = UIImage(name: imageName)
    }
}

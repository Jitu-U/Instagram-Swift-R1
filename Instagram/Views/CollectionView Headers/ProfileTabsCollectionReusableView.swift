//
//  ProfileTabsCollectionReusableView.swift
//  Instagram
//
//  Created by Jitesh gamit on 01/06/21.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapGridButton()
    func didTapTaggedButton()
}

final class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsCollectionReusableView"
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    private let gridButton: UIButton = {
       let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "squareshape.split.3x3"), for: .normal)
        return button
    }()
    
    private let taggedButton: UIButton = {
       let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .label
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        addSubview(taggedButton)
        addSubview(gridButton)
        
        gridButton.addTarget(self,
                             action: #selector(didTapGridButton),
                             for: .touchUpInside)
        taggedButton.addTarget(self,
                             action: #selector(didTapTaggedButton),
                             for: .touchUpInside)
    }
    
    @objc private func didTapGridButton(){
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .systemGray
        delegate?.didTapGridButton()
    }
    
    @objc private func didTapTaggedButton(){
        taggedButton.tintColor = .systemBlue
        gridButton.tintColor = .systemGray
        delegate?.didTapTaggedButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        print(height)
        let size = height - 25
        let gridX = ((width/2)-(height/2))/2
        gridButton.frame = CGRect(x: gridX,
                                    y: 10,
                                    width: size,
                                    height: size)
        taggedButton.frame = CGRect(x: gridX + width/2,
                                    y: 10,
                                    width: size,
                                    height: size)
        
    }
}

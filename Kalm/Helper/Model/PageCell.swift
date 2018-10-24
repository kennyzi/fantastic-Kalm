//
//  PageCell.swift
//  Kalm
//
//  Created by Klaudius Ivan on 04/06/18.
//  Copyright © 2018 Klaudius. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell{
    
    // MARK: - Variables
    let tutorialImageView: UIImageView = {
       let imageView = UIImageView(image: #imageLiteral(resourceName: "First Page"))
        
        // this enable autolayout for our imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function declarations
    private func setupLayout(){
        let topImageContainerView = UIView()

        addSubview(topImageContainerView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo:  leadingAnchor).isActive = true

        topImageContainerView.addSubview(tutorialImageView)
        tutorialImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        tutorialImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        tutorialImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 1).isActive = true

        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier:1).isActive = true
    }
}

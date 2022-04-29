//
//  TitleHeaderCollectionReusableView.swift
//  4thtaskSwift
//
//  Created by Anastasia on 21.04.2022.
//

import UIKit

class TitleHeaderCollectionReusableView: UICollectionReusableView {
    public static let identifier = "TitleHeaderCollectionReusableView"
        
        private let nameLabel: UILabel = {
            let label = UILabel()
            label.backgroundColor = .systemBackground
            label.textColor = .label
            label.font = .systemFont(ofSize: 18, weight: .semibold )
            label.textAlignment = .natural
            label.numberOfLines = 1
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .systemBackground
            addSubview(nameLabel)
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            nameLabel.frame = CGRect(x: 20,
                                     y: 5,
                                     width: 200,
                                     height: 20)
        }
        
        public func configure(with title: String) {
            self.nameLabel.text = title
        }
}

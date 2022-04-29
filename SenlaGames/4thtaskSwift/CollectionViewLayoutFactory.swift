//
//  CollectionViewLayoutFactory.swift
//  4thtaskSwift
//
//  Created by Anastasia on 15.04.2022.
//

import UIKit


public enum CollectionViewLayoutFactory {
    
    static func historyFeedLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let section = HistorySectionType.init(rawValue: sectionIndex) else {
                fatalError("Section layout is not implemented :(")
            }
            switch section {
            case .bestSet:
                return CollectionViewLayoutFactory.createHistorBestSetSectionLayout()
            case .game:
                return CollectionViewLayoutFactory.createHistoryGameSectionLayout()
            case .cube:
                return CollectionViewLayoutFactory.createHistoryCubeSectionLayout()
            }
        }
        return layout
    }
}


private extension CollectionViewLayoutFactory {
    
    static func createHistoryGameSectionLayout() -> NSCollectionLayoutSection {
        let supplementaryItems = [
                    NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                           heightDimension: .absolute(30)),
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top)
                ]
        let offset: CGFloat = 10
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                             heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: offset, leading: offset, bottom: offset, trailing: offset)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitem: item,
                                                     count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = supplementaryItems
        return section
    }
    
    static func createHistoryCubeSectionLayout() -> NSCollectionLayoutSection {
        let supplementaryItems = [
                    NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                           heightDimension: .absolute(30)),
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top)
                ]
        let offset: CGFloat = 10
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                             heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: offset, leading: offset, bottom: offset, trailing: offset)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(75))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitem: item,
                                                     count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = supplementaryItems
        return section
    }
    
    static func createHistorBestSetSectionLayout() -> NSCollectionLayoutSection {
        let supplementaryItems = [
                    NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                           heightDimension: .absolute(30)),
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top)
                ]
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .absolute(245)
        )
        let offset: CGFloat = 10
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                             heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: offset, leading: offset, bottom: offset, trailing: offset)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = supplementaryItems
        return section
    }
}

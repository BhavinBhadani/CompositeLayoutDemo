//
//  SearchDataSourceExtensions.swift
//  HashMemo
//
//  Created by Bhavin Bhadani on 28/03/23.
//

import Foundation
import UIKit

struct ForYouItem: Hashable {
    var id: String = UUID().uuidString
}

extension SearchLandingViewController {
    // Define the data source and snapshot types
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    // Define the sections of the collection view
    enum Section: CaseIterable {
        case forYou
        case usersToExplore
        case popularHashtags
        case questionAndAnswer
    }
    
    // Define the items in each section of the collection view
    enum Item: Hashable {
        case recommended(ForYouItem)
        case exploreUsers(ForYouItem)
        case popularHashtags(ForYouItem)
        case questionAndAnswer(ForYouItem)
    }
    
    // Configures the collection view by setting up the layout and registering cells and supplementary views
    func configureCollectionView() {
        // Set up the collection view layout
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        
        // Register cells
        collectionView.register(
            SearchRecommendedCollectionViewCell.nib,
            forCellWithReuseIdentifier: SearchRecommendedCollectionViewCell.identifier
        )
        collectionView.register(
            SearchExploreUserCollectionViewCell.nib,
            forCellWithReuseIdentifier: SearchExploreUserCollectionViewCell.identifier
        )
        collectionView.register(
            SearchPopularHashTagCollectionViewCell.nib,
            forCellWithReuseIdentifier: SearchPopularHashTagCollectionViewCell.identifier
        )
        collectionView.register(
            SearchAccountCollectionViewCell.nib,
            forCellWithReuseIdentifier: SearchAccountCollectionViewCell.identifier
        )
        
        // Register supplementary views
        collectionView.register(
            SearchLandingCollectionHeaderView.nib,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SearchLandingCollectionHeaderView.identifier
        )

        // Set the data source and delegate
        collectionView.dataSource = datasource
        
        // Create a list of items and apply the snapshot
        var items: [ForYouItem] = []
        for _ in 1...10 {
            items.append(ForYouItem())
        }
        applySnapshot(with: items, animatingDifferences: false)
    }

    // Creates the collection view data source
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView
        ) { [unowned self] (collectionView, indexPath, item) in
            return self.cell(collectionView: collectionView, indexPath: indexPath, item: item)
        }
        
        // Set the supplementary view provider
        datasource.supplementaryViewProvider = { [unowned self] (collectionView, kind, indexPath) in
            guard kind == UICollectionView.elementKindSectionHeader else {
              return nil
            }
            return self.supplementary(collectionView: collectionView, kind: kind, indexPath: indexPath)
        }
        
        return dataSource
    }
    
    // Applies the snapshot to the data source
    func applySnapshot(with list: [ForYouItem], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list.map { Item.recommended($0) }, toSection: .forYou)
        snapshot.appendItems(list.map { Item.exploreUsers($0)}, toSection: .usersToExplore)
        snapshot.appendItems(list.map { Item.popularHashtags($0)}, toSection: .popularHashtags)
        snapshot.appendItems(list.map { Item.questionAndAnswer($0)}, toSection: .questionAndAnswer)
        datasource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    // Returns the appropriate cell for a given item
    private func cell(collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell {
        switch item {
        case .recommended(let data):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SearchRecommendedCollectionViewCell.identifier,
                for: indexPath
            ) as! SearchRecommendedCollectionViewCell
            return cell
            
        case .exploreUsers(let data):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SearchExploreUserCollectionViewCell.identifier,
                for: indexPath
            ) as! SearchExploreUserCollectionViewCell
            return cell

        case .popularHashtags(let data):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SearchPopularHashTagCollectionViewCell.identifier,
                for: indexPath
            ) as! SearchPopularHashTagCollectionViewCell
            return cell

        case .questionAndAnswer(let data):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SearchAccountCollectionViewCell.identifier,
                for: indexPath
            ) as! SearchAccountCollectionViewCell
            return cell

        }
    }
    
    // Returns the appropriate supplementary view for a given item
    private func supplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SearchLandingCollectionHeaderView.identifier,
            for: indexPath
        ) as! SearchLandingCollectionHeaderView
        //let section = datasource.snapshot().sectionIdentifiers[indexPath.section]
        return header
    }

    
}

// MARK: - Layout

extension SearchLandingViewController {
    
    func createRecommendedSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(172),
                                                            heightDimension: .fractionalHeight(1)))
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(172),
            heightDimension: .absolute(185)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 8
        
        let supplymentryItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(50)
        )
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: supplymentryItemSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .topLeading
            )
        ]
        
        return section
    }
    
    func createExploreUsersSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(86),
                                                            heightDimension: .fractionalHeight(1)))
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(86),
            heightDimension: .absolute(116)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 8
        
        let supplymentryItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(50)
        )
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: supplymentryItemSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .topLeading
            )
        ]

        return section
    }

    func createPopulatHashtagsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(194),
                                                            heightDimension: .fractionalHeight(1)))
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(194),
            heightDimension: .absolute(170)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        
        let supplymentryItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(50)
        )
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: supplymentryItemSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .topLeading
            )
        ]

        return section
    }

    func sectionFor(index: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = datasource.snapshot().sectionIdentifiers[index]
        switch section {
        case .forYou:
            return createRecommendedSection()
        case .usersToExplore:
            return createExploreUsersSection()
        case .popularHashtags:
            return createPopulatHashtagsSection()
        case .questionAndAnswer:
            return createPopulatHashtagsSection()
        }
    }
        
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [unowned self] index, env in
            return self.sectionFor(index: index, environment: env)
        }
    }
}

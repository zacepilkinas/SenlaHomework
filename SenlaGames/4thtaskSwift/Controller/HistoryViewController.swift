//
//  HistoryViewController.swift
//  4thtaskSwift
//
//  Created by Anastasia on 15.04.2022.
//

import UIKit


enum HistorySectionType: Int {
    case bestSet
    case game
    case cube
    
    var titleHeader: String {
         switch self {
         case .bestSet:
             return "Best result"
         case .game:
             return "RPS history"
         case .cube:
             return "Rolling dice history"
         }
     }
}


class HistoryViewController: UIViewController, UICollectionViewDelegate {
   
    private var sections: [HistorySectionType] = [.bestSet, .game, .cube]

    private var dataStore = DataStore()
    private lazy var dataSource = makeDataSource()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: CollectionViewLayoutFactory.historyFeedLayout())
        view.delegate = self
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
        view.backgroundColor = .white
        addSubviews()
        makeConstraints()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        createSnapshot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension HistoryViewController: GameViewControllerDelegate, CubeViewControllerDelegate {
    
    func showGameHistory(computer: Selection, player: Selection, final: String?) {
        let configuration = GameContentConfiguration(computerChoice: computer, urChoice: player, result: final)

        dataStore.gameData.append(configuration)
        
        if final == ("Ты выиграл") || (final == "U win") {
            dataStore.gameStatisticsData.gameStatistics += 1
        }
        
        var currentSnapshot = dataSource.snapshot()
        currentSnapshot.deleteItems(currentSnapshot.itemIdentifiers(inSection: .game))
        currentSnapshot.appendItems(dataStore.gameData.map({ gameContentConfiguration in HistoryCollectionItem(content: .game(configuration: gameContentConfiguration))
        }), toSection: .game)
        let statisticItems = currentSnapshot.itemIdentifiers(inSection: .bestSet).map { item -> HistoryCollectionItem in
            switch item.content {
            case .gameStatistics(_):
                return HistoryCollectionItem(content: .gameStatistics(configuration: dataStore.gameStatisticsData))
            default: return item
            }
        }
        currentSnapshot.deleteItems(currentSnapshot.itemIdentifiers(inSection: .bestSet))
        currentSnapshot.appendItems(statisticItems, toSection: .bestSet)
        currentSnapshot.reloadSections([.game, .bestSet])
        dataSource.apply(currentSnapshot)
    }
    
    func showCubeHistory(cubeData: String?) {
        guard let result = Int(cubeData ?? "") else {
            fatalError("Unexpected integer value recieved with string.")
        }
        dataStore.cubeData.append(CubeContnetConfiguration(result: cubeData))
        
        switch result {
        case 1: dataStore.cubeStatisticsData.one += 1
        case 2: dataStore.cubeStatisticsData.two += 1
        case 3: dataStore.cubeStatisticsData.three += 1
        case 4: dataStore.cubeStatisticsData.four += 1
        case 5: dataStore.cubeStatisticsData.five += 1
        case 6: dataStore.cubeStatisticsData.six += 1
        default: break
        }
        
        var currentSnapshot = dataSource.snapshot()
        
        currentSnapshot.deleteItems(currentSnapshot.itemIdentifiers(inSection: .cube))
        currentSnapshot.appendItems(dataStore.cubeData.map({ cubeContentConfiguration in HistoryCollectionItem(content: .cube(configuration: cubeContentConfiguration))
        }), toSection: .cube)

        let statisticItems = currentSnapshot.itemIdentifiers(inSection: .bestSet).map { item -> HistoryCollectionItem in
            switch item.content {
            case .cubeStatistics(_):
                return HistoryCollectionItem(content: .cubeStatistics(configuration: dataStore.cubeStatisticsData))
            default: return item
            }
        }
        currentSnapshot.deleteItems(currentSnapshot.itemIdentifiers(inSection: .bestSet))
        currentSnapshot.appendItems(statisticItems, toSection: .bestSet)
        currentSnapshot.reloadSections([.cube, .bestSet])
        dataSource.apply(currentSnapshot)
    }
}


private extension HistoryViewController {
    
    func addSubviews() {
        view.addSubview(collectionView)
        collectionView.register(TitleHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier)
        collectionView.delegate = self
    }
    
    func makeConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<HistorySectionType, HistoryCollectionItem> {
        let dataSource = UICollectionViewDiffableDataSource<
            HistorySectionType, HistoryCollectionItem
        >(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
            guard let section = self?.dataSource.sectionIdentifier(for: indexPath.section) else {
                return .init(frame: .zero)
            }
            switch section {
            case .game:
                return self?.createRecentCell(with: item.content, for: indexPath)
            case .cube:
                return self?.createRecentCell(with: item.content, for: indexPath)
            case .bestSet:
                return self?.createRecentCell(with: item.content, for: indexPath)
            }
        }
        dataSource.supplementaryViewProvider = { [weak self] collectionView, elementKind, indexPath in
            guard let header = collectionView.dequeueReusableSupplementaryView(
                        ofKind: elementKind,
                        withReuseIdentifier: TitleHeaderCollectionReusableView.identifier,
                        for: indexPath) as? TitleHeaderCollectionReusableView,
                  let model = self?.sections[indexPath.section] else {
                return UICollectionReusableView()
            }
            header.configure(with: model.titleHeader)
            return header
        }

        return dataSource
    }
    
    func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<HistorySectionType, HistoryCollectionItem>()
        snapshot.appendSections([.bestSet, .game, .cube])
        snapshot.appendItems([.init(content: .cubeStatistics(configuration: dataStore.cubeStatisticsData)), .init(content: .gameStatistics(configuration: dataStore.gameStatisticsData))], toSection: .bestSet)
        snapshot.appendItems(dataStore.gameData.map { feed in
                .init(content: .game(
                    configuration: .init(computerChoice: feed.computerChoice, urChoice: feed.urChoice, result: feed.result))
                )
        }, toSection: .game)
        snapshot.appendItems(dataStore.cubeData.map { feed in
                .init(content: .cube(
                    configuration: .init(result: feed.result))
            )
        }, toSection: .cube)
        dataSource.apply(snapshot)
    }
    
    func createRecentCell(with item: HistoryCollectionItem.ItemType, for indexPath: IndexPath) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        switch item {
        case .cubeStatistics(configuration: let configuration):
            cell.contentConfiguration = configuration
        case .game(configuration: let configuration):
            cell.contentConfiguration = configuration
        case .cube(configuration: let configuration):
            cell.contentConfiguration = configuration
        case .gameStatistics(configuration: let configuration):
            cell.contentConfiguration = configuration
        }
        return cell
    }
}


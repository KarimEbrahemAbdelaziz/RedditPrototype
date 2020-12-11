//
//  FeedViewController.swift
//  Reddit-Prototype-iOS
//
//  Created by Basem Emara on 2020-12-11.
//

import UIKit

class FeedViewController: UIViewController {
    private(set) lazy var tableView = createTableView()
    private(set) lazy var feedViewModel = FeedViewModel()
    
    var webService: FeedWebService = HomeFeedWebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        setupTableView()
        downloadFirstPage()
    }
    
    func downloadFirstPage() {
        HomeFeedWebService.downloadFirstPageData { [weak self] feedItemsData in
            self?.processFeedItemsData(data: feedItemsData)
        } failure: { error in
            print("Something went wrong!")
            print("Error: \(error)")
        }
    }
    
    func downloadNextPage() {
        guard let afterLink = feedViewModel.afterLink else { return }
        
        HomeFeedWebService.downloadNextPageData(afterLink: afterLink) { [weak self] feedItemsData in
            self?.processFeedItemsData(data: feedItemsData)
        } failure: { error in
            print("Something went wrong!")
            print("Error: \(error)")
        }
    }
    
    func processFeedItemsData(data: FeedItemsData) {
        var feedItemViewModels: [FeedItemViewModel] = []
        let deviceScreenWidth = Float(UIScreen.main.bounds.size.width)
        
        for feedItem in data.feedItems {
            var feedItemViewModel = FeedItemViewModel(model: feedItem)
            feedItemViewModel.thumbnailWidth = feedItem.thumbnailWidth
            feedItemViewModel.thumbnailHeight = feedItem.thumbnailHeight
            feedItemViewModel.deviceScreenWidth = deviceScreenWidth
            feedItemViewModels.append(feedItemViewModel)
        }
        
        feedViewModel.appendViewModels(viewModels: feedItemViewModels)
        feedViewModel.afterLink = data.afterLink
        tableView.reloadData()
    }
}

// MARK - Table View creation methods

extension FeedViewController {
    
    private func createTableView() -> UITableView {
        let tableViewFrame = UIScreen.main.bounds
        let tableView = UITableView(frame: tableViewFrame, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        return tableView
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        let feedCellIdentifier = String(describing: FeedTableViewCell.self)
        let loadingCellIdentifier = String(describing: LoadingTableViewCell.self)
        
        tableView.register(FeedTableViewCell.self,
                           forCellReuseIdentifier: feedCellIdentifier)
        tableView.register(LoadingTableViewCell.self,
                           forCellReuseIdentifier: loadingCellIdentifier)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

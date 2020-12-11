//
//  FeedViewModel.swift
//  Reddit-Prototype-iOS
//
//  Created by Basem Emara on 2020-12-11.
//

import Foundation

class FeedViewModel {
    public private(set) var feedItemViewModels: [FeedItemViewModel] = []
    var afterLink: String?

    var numberOfFeedItems: Int {
        return feedItemViewModels.count + (hasLoadingCell ? 1 : 0)
    }
    
    func appendViewModels(viewModels: [FeedItemViewModel]) {
        feedItemViewModels.append(contentsOf: viewModels)
    }
    
    func viewModelForCell(at index: Int) -> FeedItemViewModel? {
        guard index >= 0 && index < feedItemViewModels.count else { return nil }
        return feedItemViewModels[index]
    }
    
    var hasLoadingCell: Bool {
        return afterLink != nil && (afterLink?.count ?? 0) > 0
    }
    
    func isLoadingCell(at index: Int) -> Bool {
        return hasLoadingCell && index == feedItemViewModels.count
    }
    
    func heightForCell(at index: Int) -> Float {
        guard index >= 0 && index <= feedItemViewModels.count else { return 0.0 }
        return isLoadingCell(at: index) ? 60.0 : feedItemViewModels[index].heightForCell()
    }
}

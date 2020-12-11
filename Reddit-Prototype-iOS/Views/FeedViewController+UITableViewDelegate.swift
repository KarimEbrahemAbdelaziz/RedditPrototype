//
//  FeedViewController+UITableViewDelegate.swift
//  Reddit-Prototype-iOS
//
//  Created by Basem Emara on 2020-12-11.
//

import UIKit

// MARK: - UITableViewDelegate methods

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(feedViewModel.heightForCell(at: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard feedViewModel.isLoadingCell(at: indexPath.row), let loadinCell = cell as? LoadingTableViewCell else {
            return
        }
        
        loadinCell.startAnimating()
    }
}

//
//  FeedWebService.swift
//  Reddit-Prototype-iOS
//
//  Created by Basem Emara on 2020-12-11.
//

import UIKit

protocol FeedWebService {
    
    static func downloadFirstPageData(
        success: @escaping (FeedItemsData) -> Void,
        failure: @escaping (Error) -> Void
    )
    
    static func downloadNextPageData(
        afterLink: String,
        success: @escaping (FeedItemsData) -> Void,
        failure: @escaping (Error) -> Void
    )
}

//
//  ArticleDetailViewModel.swift
//  iOSAssessment
//
//  Created by Dev on 26/02/19.
//  Copyright © 2019 DevApp. All rights reserved.
//

import Foundation

/**
 ArticleDetail ViewModel Delegate for setting selected article
 */
protocol ArticleDetailViewModelDelegate {
    var selectedArticle: ArticleModel?  { get }
    func setSelectedArticle (article : ArticleModel)
}

/**
 ArticleDetail ViewModel for binding data in Article Detail view
 */
class ArticleDetailViewModel : ArticleDetailViewModelDelegate {
    
    var selectedArticle: ArticleModel?
    
    func setSelectedArticle (article : ArticleModel) {
        selectedArticle = article
    }
}

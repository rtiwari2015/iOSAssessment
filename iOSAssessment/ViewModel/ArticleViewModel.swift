//
//  ArticleViewModel.swift
//  iOSAssessment
//
//  Created by Dev on 26/02/19.
//  Copyright © 2019 DevApp. All rights reserved.
//

import Foundation
import UIKit

/**
 Article view model delegate for fetching data and configuring image
 */
protocol ArticleViewModelDelegate {
    var delegate: ViewModelDelegate? { get set }
    var articles: [ArticleModel]  { get }
    func fetchArticleData()
    func configureImageCacheCell(cell : ArticleListCell,article : ArticleModel, tableView : UITableView, indexPath : NSIndexPath,cache:NSCache<AnyObject, AnyObject>)
}

/**
 View model delegate for loading articles list data
 */
protocol ViewModelDelegate: class {
    func didLoadData(title:String)
}

/**
 Article View model for binding data in article list view controller
 */
class ArticleViewModel : ArticleViewModelDelegate {
    var articles: [ArticleModel] = []
    
    weak var delegate: ViewModelDelegate?
    
    // Fetches articles from the server
    func fetchArticleData() {
        ArticleDataManager.fetchArticleDetails { (title,articlesArray) in
            self.articles = articlesArray
            DispatchQueue.main.async {
                self.delegate?.didLoadData(title: title)
            }
        }
    }
    
   /**
     Congigures the image in the cell
     */
    func configureImageCacheCell(cell : ArticleListCell, article : ArticleModel, tableView : UITableView, indexPath : NSIndexPath,cache:NSCache<AnyObject, AnyObject>)  {
        
        let session = URLSession.shared
        var task = URLSessionDownloadTask()
        
        let articleUrl = article.image_url
        if let articleUrl = articleUrl {
            let url = URL.init(string: articleUrl)
            if let url = url {
                task = session.downloadTask(with: url, completionHandler: { (data, response, error) -> Void in
                    if let data = try? Data(contentsOf: url){
                        // Updates the cell images in the main thread.
                        DispatchQueue.main.async(execute: { () -> Void in
                            if let updateCell = tableView.cellForRow(at: indexPath as IndexPath) as? ArticleListCell {
                                let img:UIImage! = UIImage(data: data)
                                updateCell.articleImageView?.image = img
                                cache.setObject(img, forKey: (indexPath as NSIndexPath).row as AnyObject)
                            }
                        })
                    }
                })
                task.resume()
            }
        }
    }
}

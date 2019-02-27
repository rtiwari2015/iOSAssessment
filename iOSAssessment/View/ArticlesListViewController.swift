//
//  ArticlesListViewController.swift
//  iOSAssessment
//
//  Created by Dev on 26/02/19.
//  Copyright © 2019 DevApp. All rights reserved.
//

import UIKit

class ArticlesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var model: ArticleViewModelDelegate!
    var cache:NSCache<AnyObject, AnyObject>!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cache = NSCache()
        
        // Sets model delegate and fetches articles data from server
        model = ArticleViewModel()
        model.delegate = self
        model.fetchArticleData()
        
        // Do any additional setup after loading the view.
        
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // on selecting cell row, navigates to details view of selected article
        if (segue.identifier == "detailSegue") {
            
            let row = tableView.indexPathForSelectedRow?.row
            if let row = row {
                let detailVC = segue.destination as? ArticleDetailViewController
                detailVC?.model = ArticleDetailViewModel()
                detailVC?.model.setSelectedArticle(article: (model?.articles[row])!)
            }
        }
    }

    // MARK: - Table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier = "cell"
        let article = model?.articles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ArticleListCell
        cell?.titleLabel.text = article!.title
        cell?.contentLabel.text = article!.content
        
        // Sets a placeholder image for all the image cells.
 
        cell?.articleImageView?.image = UIImage(named: "article-placeholder.png")
        
        // Loading the already cached image if exists.

        if (self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) != nil){
            cell?.articleImageView?.image = self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage
        }
        // If Image is not available in cache, downloads the images only for visible cells.
        else {
            model?.configureImageCacheCell(cell: cell!, article: article!, tableView: tableView, indexPath: indexPath as NSIndexPath, cache: cache)
        }
        
        return cell!
    }
}

/**
 Extension for loading the articles data in table view
 */
extension ArticlesListViewController: ViewModelDelegate {
    
    // ViewModel delegate method which reloads the data
    func didLoadData(title:String) {
        self.navigationItem.title = title
            tableView.reloadData()
        }
}



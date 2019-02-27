//
//  ArticleModel.swift
//  iOSAssessment
//
//  Created by Dev on 26/02/19.
//  Copyright © 2019 DevApp. All rights reserved.
//

import Foundation


/*
 Model for the entire JSON data containing title and articles.
 */
struct DataModel: Codable {
    
    var title: String?
    var articles: [ArticleModel]?
}

/*
 Model for the articles.
 */
struct ArticleModel: Codable {
    
    var title: String?
    var website: String?
    var authors: String?
    var date: String?
    var content: String?
    var tag: Tag?
    var image_url: String?
}

/*
 Model for the tags of the articles.
 */
struct Tag: Codable {
    
    var id: Int?
    var label: String?
}

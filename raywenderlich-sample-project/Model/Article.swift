//
//  Article.swift
//  raywenderlich-sample-project
//
//  Created by Mohamed Hafez on 5/2/21.
//

import Foundation

struct Page: Decodable {
    var data: [Article]
}
struct Article: Decodable {
    var attributes: ArticleAttributes
   
    
}
struct ArticleAttributes: Decodable {
    let name: String
    let description: String
    let cardArtworkUrl: String

}


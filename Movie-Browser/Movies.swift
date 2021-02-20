//
//  Movies.swift
//  Movie-Browser
//
//  Created by Alex Paul on 2/19/21.
//

import Foundation

struct Movies: Codable, Hashable {
    let overview:String?
    let original_title: String?
    let poster_path:String
}


struct ApiResponse:Codable, Hashable {
    let page:Int
    let shows:[Movies]
    
    enum CodingKeys:String, CodingKey {
        case page = "page"
        case shows = "results"
    }
}


extension Movies{
  
    var unwrappedOverview:String {
        "\(overview ?? "Unavilable")"
    }
    
    var unwrappedOriginal_title:String {
        "\(original_title ?? "Unavilable")"
    }
    
  
}

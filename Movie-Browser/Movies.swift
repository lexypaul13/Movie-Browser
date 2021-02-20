//
//  Movies.swift
//  Movie-Browser
//
//  Created by Alex Paul on 2/19/21.
//

import Foundation

struct Movies: Codable, Hashable {
    let id: Int?
    let overview:String?
    let voteCount: Int?
    let name: String?
    let backdropPath: String?
    let voteAverage :Double?
    let firstAirDate :String?
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
    var voteAverageStr: String{
        "\(voteAverage ?? 0.0)"
    }
    
    var unwrappedOverview:String {
        "\(overview ?? "Unavilable")"
    }
    
    var unwrappedVoteCount:String {
        "\(voteCount ?? 0)"
    }
    
    var unwrappedName:String {
        "\(name ?? "No Name")"
    }
    
    var unwrappedfirstAirDate:String {
        "\(firstAirDate ?? "Unavailable")"
    }
    
}



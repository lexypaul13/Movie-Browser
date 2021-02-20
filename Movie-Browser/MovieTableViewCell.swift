//
//  MovieTableViewCell.swift
//  Movie-Browser
//
//  Created by Alex Paul on 2/19/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTile: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieDescription: UILabel!
    

    func setTableCell(movie:Movies){
        updateUI(movieTitle:movie.unwrappedOriginal_title , movieImageView: movie.poster_path, movieDescription: movie.unwrappedOverview)
        
    }
    
    private func updateUI(movieTitle:String?,movieImageView:String?,movieDescription:String?){
        self.movieTile.text = movieTitle
        self.movieDescription.text = movieDescription
        downloadTVImage(movieImageView ?? "")
    }
    
    func downloadTVImage(_ url:String) {
        NetworkManger.shared.downloadImage(from:url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.movieImageView = self.movieImageView }
        
        }
    
    
    
    

}
}

//
//  MovieDetailsViewController.swift
//  Movie-Browser
//
//  Created by Alex Paul on 2/26/21.
//

import UIKit
import AlamofireImage
class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var movie : [String:Any]?
     
    override func viewDidLoad() {
        super.viewDidLoad()
        getPosterImage()
        getBackDropImage()
        // Do any additional setup after loading the view.
    }
    

    func getPosterImage(){
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let posterPath = movie!["poster_path" ] as! String
        let posterURL = URL(string: baseUrl + posterPath)
        posterImage.af.setImage(withURL: posterURL!)
        
}
    
    
    func getBackDropImage(){
        let title = movie!["title"] as! String
        titleLabel.text = title
        let overview = movie!["overview"] as! String
        descriptionLabel.text = overview
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let backDropPath = movie!["backdrop_path" ] as! String
        let posterImagerURL = URL(string: baseUrl + backDropPath)
        backImage.af.setImage(withURL: posterImagerURL!)
        
}
    
    
}

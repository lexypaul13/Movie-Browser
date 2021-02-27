//
//  MoiveGridViewController.swift
//  Movie-Browser
//
//  Created by Alex Paul on 2/26/21.
//

import UIKit
import AlamofireImage
class MoiveGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var movies = [[String:Any]]()

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
      getMovies()
        configureCollectionView()
        // Do any additional setup after loading the view.
    }
    
    func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 40
        layout.minimumInteritemSpacing = 0
        let width = (view.frame.size.width - layout.minimumLineSpacing * 2)/3
        layout.itemSize = CGSize(width: width, height: width * 3/2)
        
    }

    func getMovies(){
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            self.movies = dataDictionary["results"] as! [[String:Any]]
            self.collectionView.reloadData()

           }
        }
        task.resume()
        }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(  withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        
        let movie = movies[indexPath.item]
        let overview = movie["overview"] as! String

        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let posterPath = movie["poster_path" ] as! String
        let posterURL = URL(string: baseUrl + posterPath)
      
        cell.moviePicture.af.setImage(withURL: posterURL!)
        
        return cell
     }
}

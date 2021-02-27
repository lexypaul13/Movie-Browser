//
//  ViewController.swift
//  Movie-Browser
//
//  Created by Alex Paul on 2/19/21.
//

import UIKit
import AlamofireImage
class MovieViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getMovies()
    }

    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getMovies(){
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            self.movies = dataDictionary["results"] as! [[String:Any]]
            self.tableView.reloadData() 
            

           }
        }
        task.resume()
        }
    
}

extension MovieViewController: UITableViewDataSource, UITableViewDelegate{
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
       
        cell.movieTile!.text = title
        cell.movieDescription!.text = overview
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! MovieTableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        let detailViewcontroller = segue.destination as! MovieDetailsViewController
        detailViewcontroller.movie = movie
        
    }
    
}

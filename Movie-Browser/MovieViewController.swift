//
//  ViewController.swift
//  Movie-Browser
//
//  Created by Alex Paul on 2/19/21.
//

import UIKit

class MovieViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    var movies = [Results]()
    
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
            NetworkManger.shared.get(.showList, urlString: "") { [weak self] (result: Result<Movies,ErroMessage> ) in
                guard let self = self else { return }
                switch result{
                case .success(let apiResult):
                    self.movies = apiResult.results ?? []
                    DispatchQueue.main.async {self.tableView.reloadData()}

                case .failure(let error):
                    print(error.localizedDescription)
                }

            }
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 163
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        let movie = movies[indexPath.row]
        cell.setTableCell(movie: movie)
        return cell
    }
    


    
    
    
}


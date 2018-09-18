//
//  MoviePlayingViewController.swift
//  FlixApp
//
//  Created by Isaac Samuel on 9/17/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit

class MoviePlayingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [[String: Any]] = []
    //var movies = [NSDictionary]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 168
        tableView.estimatedRowHeight = 200

        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) {(data, response, error) in
            //-- This will run when the network request returns
            if let error = error{
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                // ----- first
                print(dataDictionary)
                
                // Get the dictionary from the response key
                //let responseDictionary = dataDictionary["response"] as! [String: Any]
                //self.posts = responseDictionary["posts"] as! [[String: Any]]
                //self.tableView.reloadData()
                //print(dataDictionary)
                
                
                let movies = dataDictionary["results"] as! [[String: Any]]
                for movie in movies {
                    let title =  movie ["title"] as! String
                    print(title)
                }
                //self.movies = dataDictionary["results"] as! [[String: Any]]
                //self.tableView.reloadData()
                
            }
            
        }
        task.resume()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        //let movie = movies[indexPath.row]
        //let title = movie["title"] as! String
        //let overview = movie["overview"] as! String
        //cell.titleLabel.text = title
        //cell.overviewTextView.text = overview
        
        cell.textLabel?.text = "row \(indexPath.row)"
        print("row \(indexPath.row)")
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

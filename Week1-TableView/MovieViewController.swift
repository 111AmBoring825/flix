//
//  MovieViewController.swift
//  Flix
//
//  Created by lxy on 2/13/21.
//

import UIKit
import AlamofireImage

class MovieViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    
    //*** manually added "UITableViewDataSource, UITableViewDelegate" and click fix to add expected functions
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies=[[String:Any]]() //*** creation of array of dictionary
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self       //*** define tableView fields
        
        // Do any additional setup after loading the view.
        print("Hello")
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            self.movies=dataDictionary["results"] as![[String:Any]] //*** store data to be call in another function
            self.tableView.reloadData()             //ask it to have call tableView function again
            print(dataDictionary)
              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }
        }
        task.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //# of rows=?
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //*** this function will be called numberOfRowsInSection times to present each cell
        let cell=tableView.dequeueReusableCell(withIdentifier: "MovieCell") as!MovieCell //***if other cells are off screen, dequeue it to be reused for following movie (in case of large # of movies)
        let movie=movies[indexPath.row]
        let title=movie["title"] as!String  //"as" casting title to string
        let synopsis=movie["overview"] as!String
        
        cell.titleLable.text=title
        cell.synopsisLable.text=synopsis
        
        let baseUrl="https://image.tmdb.org/t/p/w185"
        let posterPath=movie["poster_path"] as!String
        let posterUrl=URL(string: baseUrl+posterPath)
        
        cell.posterView.af.setImage(withURL:posterUrl!)
        
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //find selected movie
        let cell=sender as!UITableViewCell
        let indexPath=tableView.indexPath(for:cell)!
        let movie = movies[indexPath.row]
        
        //pass it to detailViewController
        let detailsViewController=segue.destination as! MovieDetailsViewController
        detailsViewController.movie=movie
        tableView.deselectRow(at: indexPath, animated: true)//so when back to movies, selected history no showing
    }
    

}

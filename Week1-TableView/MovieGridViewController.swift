//
//  MovieGridViewController.swift
//  Flix
//
//  Created by lxy on 2/21/21.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var movies=[[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate=self
        collectionView.dataSource=self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            self.movies=dataDictionary["results"] as![[String:Any]] //*** store data to be call in another function
            self.collectionView.reloadData()
        

           }
        }
        task.resume()

        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath)as! MovieGridCell
        
        let movie=movies[indexPath.item]
        
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
        let cell=sender as!UICollectionViewCell
        let indexPath=collectionView.indexPath(for:cell)!
        let movie = movies[indexPath.row]
        
        //pass it to detailViewController
        let detailsViewController=segue.destination as! MovieDetailsViewController
        detailsViewController.movie=movie
    }
    

} //

//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by lxy on 2/21/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var synopsisLable: UILabel!
    
    
    var movie:[String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        titleLable.text=movie["title"]as? String
        titleLable.sizeToFit()              //grow until fit
        
        synopsisLable.text=movie["overview"]as? String
        synopsisLable.sizeToFit()
        
        let baseUrl="https://image.tmdb.org/t/p/w185"
        let posterPath=movie["poster_path"] as!String
        let posterUrl=URL(string: baseUrl+posterPath)
        
        posterView.af.setImage(withURL:posterUrl!)
        
        let backdropPath=movie["backdrop_path"] as!String
        let backdropUrl=URL(string: "https://image.tmdb.org/t/p/w780"+backdropPath)
        
        backdropView.af.setImage(withURL:backdropUrl!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

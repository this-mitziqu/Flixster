//
//  DetailViewController.swift
//  Flixster
//
//  Created by Mingxuan Qu on 3/7/23.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var voteAverageLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var voteCountLabel: UILabel!
    
    
    @IBOutlet weak var popularityLabel: UILabel!
    
    @IBOutlet weak var overviewTextView: UITextView!
    var movie: Movie!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        Nuke.loadImage(with: movie.backdropPath, into: movieImageView)
        titleLabel.text = movie.title
        voteAverageLabel.text = String(movie.voteAverage)+" Vote Average"
        voteCountLabel.text = String(movie.voteCount) + " Votes"
        popularityLabel.text = String(movie.popularity) + " Popularity"
        overviewTextView.text = movie.overview
        
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

//
//  MovieCell.swift
//  Flixster
//
//  Created by Mingxuan Qu on 3/5/23.
//

import UIKit
import Nuke

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var movieNameLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with movie: Movie){
        movieNameLabel.text = movie.title
        overviewLabel.text = movie.overview
        Nuke.loadImage(with: movie.posterPath, into: movieImageView)
    }

}
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
    
    var movies:[Movie]=[]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let path = movie.backdrop_path{
            Nuke.loadImage(with: URL(string: "https://image.tmdb.org/t/p/w1280"+path)!, into: movieImageView)
        }
        titleLabel.text = movie.title
        voteAverageLabel.text = String(movie.vote_average)+" Vote Average"
        voteCountLabel.text = String(movie.vote_count) + " Votes"
        popularityLabel.text = String(movie.popularity) + " Popularity"
        overviewTextView.text = movie.overview
        
        
        //get similar movie list
        let url = URL(string: "https://api.themoviedb.org/3/movie/"+String(movie.id)+"/similar?api_key=65d9f065f3cd220afe9c8dc08cf43318")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
            }
            guard let data = data else {
                print("❌ Data is nil")
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MoviesResponse.self, from: data)
                let movies = response.results
                DispatchQueue.main.async{
                    self?.movies = movies
                }
            }  catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print(url)
                print("Value '\(value)' not found:", context.debugDescription)
                
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }

        // Initiate the network request
        task.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func didTapSimilar(_ sender: UITapGestureRecognizer) {
        if let tappedView = sender.view {
            performSegue(withIdentifier: "similarSegue", sender: tappedView)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "similarSegue",
            let viewController = segue.destination as? ViewController {
                viewController.movies = movies
                viewController.isSimilar = true
            viewController.navBarTitle = movie.title
                }
    }
    
    

}

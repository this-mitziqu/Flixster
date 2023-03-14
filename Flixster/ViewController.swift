//
//  ViewController.swift
//  Flixster
//
//  Created by Mingxuan Qu on 3/5/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie]=[]
    var navBarTitle: String = ""
    
    var isSimilar: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //movies = Movie.mockMovies
        // Create a URL for the request
        // In this case, the custom search URL you created in in part 1
        if !isSimilar {
            let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=65d9f065f3cd220afe9c8dc08cf43318")!
            
            // Use the URL to instantiate a request
            let request = URLRequest(url: url)
            
            // Create a URLSession using a shared instance and call its dataTask method
            // The data task method attempts to retrieve the contents of a URL based on the specified URL.
            // When finished, it calls it's completion handler (closure) passing in optional values for data (the data we want to fetch), response (info about the response like status code) and error (if the request was unsuccessful)
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                
                // Handle any errors
                if let error = error {
                    print("❌ Network error: \(error.localizedDescription)")
                }
                
                // Make sure we have data
                guard let data = data else {
                    print("❌ Data is nil")
                    return
                }
                
                // The `JSONSerialization.jsonObject(with: data)` method is a "throwing" function (meaning it can throw an error) so we wrap it in a `do` `catch`
                // We cast the resultant returned object to a dictionary with a `String` key, `Any` value pair.
                do {
                    let decoder = JSONDecoder()
                    
                    // Use the JSON decoder to try and map the data to our custom model.
                    // TrackResponse.self is a reference to the type itself, tells the decoder what to map to.
                    let response = try decoder.decode(MoviesResponse.self, from: data)
                    
                    // Access the array of tracks from the `results` property
                    let movies = response.results
                    DispatchQueue.main.async{
                        self?.movies = movies
                        self?.tableView.reloadData()
                    }
                } catch {
                    print("❌ Error parsing JSON in ViewConroller.swift: \(error.localizedDescription)")
                }
            }
            
            // Initiate the network request
            task.resume()
        }else{
            self.navigationItem.title = "Similar Movies to "+navBarTitle
        }
            tableView.dataSource = self
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the cell that triggered the segue
        if let cell = sender as? UITableViewCell,
           // Get the index path of the cell from the table view
           let indexPath = tableView.indexPath(for: cell),//Returns an index path that represents the row and section of a specified table-view cell.
           // Get the detail view controller
           let detailViewController = segue.destination as? DetailViewController {

            let movie = movies[indexPath.row]

            detailViewController.movie = movie
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Get the index path for the current selected table view row (if exists)
        if let indexPath = tableView.indexPathForSelectedRow {
            // Deselect the row at the corresponding index path
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }


}


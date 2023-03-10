//
//  DetailMovieViewController.swift
//  Movies
//
//  Created by Emir Arıkan on 25.01.2023.
//

import UIKit
import Firebase
class DetailMovieViewController: UIViewController {
    var movieDetail : Movies?
    var ref:DatabaseReference!
    var isMovieFavorite:Bool = false
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieDirectorLabel: UILabel!
    @IBOutlet weak var movieDefinitionLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    @IBOutlet weak var movieimdbScoreLabel: UILabel!
    @IBOutlet weak var movieImdbLabel: UIStackView!
    @IBOutlet weak var image: UIStackView!
    @IBOutlet weak var addButton: UIButton!
    override func viewDidLoad() {
        if isMovieFavorite == true{
            addButton.setTitle("Remove to Favorites", for: UIControl.State.normal)
        }
        super.viewDidLoad()
        ref = Database.database().reference()
        if let movieDetail = movieDetail{
            movieNameLabel.text = movieDetail.movie_name
            movieDirectorLabel.text = movieDetail.movie_director
            movieDefinitionLabel.text = movieDetail.movie_definition
            movieimdbScoreLabel.text = "\(movieDetail.movie_imdb!)/10 IMDb"
            movieDateLabel.text = String(movieDetail.movie_date!)
            movieImageView.image = UIImage(named: movieDetail.movie_image!)
            
            
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addFav(_ sender: Any) {
        if let movieDetail = movieDetail{
            if isMovieFavorite == false{
                
                let dict:[String:Any] = ["film_id":"","film_ad":movieDetail.movie_name,"film_imdb":movieDetail.movie_imdb,"film_aciklama":movieDetail.movie_definition,"film_resim":movieDetail.movie_image,"film_yil":movieDetail.movie_date,"kategori_ad":movieDetail.movie_category,"yonetmen_ad":movieDetail.movie_director]
                let newRef = ref.child("favfilm").childByAutoId()
                newRef.setValue(dict)
                let ac = UIAlertController(title: "Succesfull", message:"Successfully added to favorite movies", preferredStyle: .alert)
                let ad = UIAlertAction(title: "OK", style: .default)
                ac.addAction(ad)
                present(ac,animated: true)
                
            }
            else{
                self.ref.child("favfilm").child(movieDetail.movie_id!).removeValue()
                let ac = UIAlertController(title: "Succesfull", message:"Successfully remove to favorite movies", preferredStyle: .alert)
                let ad = UIAlertAction(title: "OK", style: .default)
                ac.addAction(ad)
                present(ac,animated: true)
            }}
    }
    
    
}

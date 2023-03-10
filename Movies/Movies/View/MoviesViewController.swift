//
//  MoviesViewController.swift
//  Movies
//
//  Created by Emir Arıkan on 24.01.2023.
//

import UIKit
import Firebase
class MoviesViewController: UIViewController {
    var movieList = [Movies]()
    var ref:DatabaseReference!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        
        
        let design : UICollectionViewFlowLayout  = UICollectionViewFlowLayout()
        let collectionViewWidth = self.collectionView.frame.size.width
        design.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        design.itemSize = CGSize(width: collectionViewWidth, height: 180)
        design.minimumLineSpacing = 10
        
        collectionView.collectionViewLayout = design
        ref = Database.database().reference()
       takeMovie()
    }
    func takeMovie(){
        ref.child("filmler").observe(.value, with: {snapshot in
            if let gelenVeriButunu = snapshot.value as? [String:AnyObject]{
                self.movieList.removeAll()
                for gelenSatirVerisi in gelenVeriButunu{
                    if let sozluk = gelenSatirVerisi.value as? NSDictionary {
                        let key = gelenSatirVerisi.key
                        let movie_name = sozluk["film_ad"] as? String ?? ""
                        let movie_image = sozluk["film_resim"] as? String ?? ""
                        let movie_date = sozluk["film_yil"] as? Int ?? 0
                        let movie_category = sozluk["kategori_ad"] as? String ?? ""
                        let movie_director = sozluk["yonetmen_ad"] as? String ?? ""
                        let movie_definition = sozluk["film_aciklama"] as? String ?? ""
                        let movie_imdb = sozluk["film_imdb"] as? String ?? ""

                      
                        let nowMovie = Movies(movie_id: key, movie_name: movie_name, movie_date: movie_date, movie_image: movie_image, movie_definition: movie_definition, movie_imdb: movie_imdb, movie_category: movie_category, movie_director: movie_director)
                        self.movieList.append(nowMovie)
                    }
                }
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }

}

extension MoviesViewController:UICollectionViewDelegate,UICollectionViewDataSource,MovieCollectionViewCellDelegate{
    func navigateToMovieDetail(indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetail") as? DetailMovieViewController else { return }
        vc.movieDetail = movieList[indexPath.row]
        vc.isMovieFavorite = false
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = movieList[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieColl", for: indexPath) as! MovieCollectionViewCell
        cell.setMovieName(with: movieList[indexPath.row].movie_name!)
        cell.setMovieDate(with: movie.movie_date!)
        cell.setMovieImdb(with: "\(movie.movie_imdb!) IMDb")
        cell.setMovieImage(with: movie.movie_image!)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.5
        cell.movieColl = self
        cell.indexPath = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }


}

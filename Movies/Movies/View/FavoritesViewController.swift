//
//  FavoritesViewController.swift
//  Movies
//
//  Created by Emir Arıkan on 24.01.2023.
//

import UIKit
import Firebase

class FavoritesViewController: UIViewController{
    
    var favList = [Movies]()
    var ref:DatabaseReference!
    
    @IBOutlet private weak var favCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        favCollectionView.delegate = self
        favCollectionView.dataSource = self
        ref = Database.database().reference()
        
        let design : UICollectionViewFlowLayout  = UICollectionViewFlowLayout()
        let collectionViewWidth = self.favCollectionView.frame.size.width
        design.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        design.itemSize = CGSize(width: collectionViewWidth, height: 180)
        design.minimumLineSpacing = 10
        
        favCollectionView.collectionViewLayout = design
        ref = Database.database().reference()
        takeMovie()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.takeMovie()
    }
    func takeMovie(){
        ref.child("favfilm").observe(.value, with: {snapshot in
            if let gelenVeriButunu = snapshot.value as? [String:AnyObject]{
                self.favList.removeAll()
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
                        self.favList.append(nowMovie)
                    }else{
                        self.favList = [Movies]()
                    }
                }
            }
            DispatchQueue.main.async {
                self.favCollectionView.reloadData()
            }
        })
    }
    
    
    
}
extension FavoritesViewController:UICollectionViewDelegate,UICollectionViewDataSource,FavoriteCollectionViewCellDelegate {
    
    func navigateToMovieDetail(indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetail") as? DetailMovieViewController else { return }
        vc.movieDetail = favList[indexPath.row]
        vc.isMovieFavorite = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = favList[indexPath.row]
        let cell = favCollectionView.dequeueReusableCell(withReuseIdentifier: "favColl", for: indexPath) as! FavoritesCollectionViewCell
        cell.setMovieName(with: favList[indexPath.row].movie_name!)
        cell.setMovieDate(with: movie.movie_date!)
        cell.setMovieImdb(with: "\(movie.movie_imdb!) IMDb")
        cell.setMovieImage(with: movie.movie_image!)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.5
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favList.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

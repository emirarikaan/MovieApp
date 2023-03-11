//
//  FavoritesCollectionViewCell.swift
//  Movies
//
//  Created by Emir Arıkan on 24.01.2023.
//

import UIKit
protocol FavoriteCollectionViewCellDelegate : AnyObject{
    func navigateToMovieDetail(indexPath:IndexPath)
}

final class FavoritesCollectionViewCell: UICollectionViewCell{
    var a = 0
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieDateLabel: UILabel!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var movieImdbLabel: UILabel!
    weak var delegate:FavoriteCollectionViewCellDelegate?
    var indexPath:IndexPath?
    
    @IBAction private func reviewButtonTapped(_ sender: Any) {
        guard let indexPath = indexPath else { return }
        delegate?.navigateToMovieDetail(indexPath: indexPath)
    }
    
    func setMovieName(with name:String?){
        guard let name = name else {return}
        movieNameLabel.text = name
    }
    func setMovieDate(with date:Int?){
        guard let date = date else {return}
        movieDateLabel.text = String(date)
    }
    func setMovieImdb(with imdb:String?){
        guard let imdb = imdb else {return}
        movieImdbLabel.text = imdb
    }
    func setMovieImage(with image:String?){
        guard let image = image else {return}
        movieImageView.image = UIImage(named: image)
    }
    
}

//
//  Filmler.swift
//  Movies
//
//  Created by Emir Arıkan on 24.01.2023.
//

import Foundation

class Movies {
    var movie_id:String?
    var movie_name:String?
    var movie_date:Int?
    var movie_image:String?
    var movie_definition:String?
    var movie_imdb:String?
    var movie_category:String?
    var movie_director:String?
    
    
    init(movie_id:String,movie_name:String,movie_date:Int,movie_image:String,movie_definition:String,movie_imdb:String,movie_category:String,movie_director:String) {
        self.movie_id = movie_id
        self.movie_name = movie_name
        self.movie_date = movie_date
        self.movie_image = movie_image
        self.movie_definition = movie_definition
        self.movie_imdb = movie_imdb
        self.movie_category = movie_category
        self.movie_director = movie_director
    }
}

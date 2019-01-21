//
//  Playlist.swift
//  deezerPlaylistAPI
//
//  Created by Adadémey Marvin on 20/01/2019.
//  Copyright © 2019 Adadémey Marvin. All rights reserved.
//

import Foundation

struct Playlist : Decodable{
    let pictureURL : String
    let title : String
    let numberOfSongs : Int
    let creationDate : String
    let owner : String
    let id : Int
}

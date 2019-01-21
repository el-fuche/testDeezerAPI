//
//  SongsModel.swift
//  deezerPlaylistAPI
//
//  Created by Adadémey Marvin on 21/01/2019.
//  Copyright © 2019 Adadémey Marvin. All rights reserved.
//

import Foundation

struct Song : Decodable{
    let duration : Int
    let title : String
}

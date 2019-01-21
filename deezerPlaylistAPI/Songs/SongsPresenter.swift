//
//  SongsPresenter.swift
//  deezerPlaylistAPI
//
//  Created by Adadémey Marvin on 21/01/2019.
//  Copyright © 2019 Adadémey Marvin. All rights reserved.
//

import Foundation
import RxSwift

class SongsPresenter {
    var songs = [Song]()
    let disposeBag = DisposeBag()
    var controller : SongsViewController?
    
    func attachController(controllerToAttach:SongsViewController){
        self.controller = controllerToAttach
    }
    
    func getSongs(playlistID:String,songsArray:@escaping ([Song]?) -> ()){
        Manager.instance.getSongsFromPlaylist(playlistID: playlistID, datas: { (datas, error) in
            if datas != nil && error == nil{
                if let receivedSongs = datas{
                    self.songs = receivedSongs
                    songsArray(self.songs)
                }
            }
        })
    }

}

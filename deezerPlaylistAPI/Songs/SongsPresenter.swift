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
    
    /// To bind the presenter to the view controller
    ///
    /// - Parameter controllerToAttach: controller to bind
    func attachController(controllerToAttach:SongsViewController){
        self.controller = controllerToAttach
    }
    
    /// To return the title on the view controller
    ///
    /// - Returns: the title
    func getTitle()->String{
        return "Albums"
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
    
    /// Get songs the "RX way"
    ///
    /// - Parameters:
    ///   - pid: playlistID
    ///   - songsArray: array To store the songs
    func getRXSongs(pid:String,songsArray:@escaping ([Song]?) -> ()){
        Manager.instance.getRxSongsFromPlaylist(playlistID: pid)
            .subscribe(
                onNext: { songsReceived in
                    print(songsReceived)
                    self.songs = songsReceived
                    songsArray(self.songs)
            },
                onError: { error in
                    print(error)
            }
            ).disposed(by: disposeBag)
    }
    
    func getFormattedTime(totalTime:Int)->(minutes:Int,seconds:Int){
       return Manager.instance.getFormattedVideoTime(totalVideoDuration: totalTime)
    }

}

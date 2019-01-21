//
//  PlaylistPresenter.swift
//  deezerPlaylistAPI
//
//  Created by Adadémey Marvin on 20/01/2019.
//  Copyright © 2019 Adadémey Marvin. All rights reserved.
//

import Foundation
import RxSwift
class PlaylistPresenter {
    var playlists = [Playlist]()
    let disposeBag = DisposeBag()
    var controller : PlaylistViewController?
    
    func attachController(controllerToAttach:PlaylistViewController){
        self.controller = controllerToAttach
    }
    
    func getPlaylists(userId:String,playlistArray:@escaping ([Playlist]?) -> ()){
        Manager.instance.getUserPlaylists(userID: userId) { (datas, error) in
            if datas != nil && error == nil{
                if let receivedPlaylists = datas{
                    self.playlists = receivedPlaylists
                    playlistArray(self.playlists)
                }
            }
        }
        
    }
    
    func getRXPlaylist(uid:String,playlistArray:@escaping ([Playlist]?) -> ()){
        Manager.instance.getRxPlaylist(userID: uid)
            .subscribe(
                onNext: { playlistsReceived in
                    print(playlistsReceived)
                    self.playlists = playlistsReceived
                    playlistArray(self.playlists)
            },
                onError: { error in
                    print(error)
            }
            ).disposed(by: disposeBag)
    }
    
    func goToSelectedPlaylist(playlistID:String){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SongsViewController") as? SongsViewController{
            nextViewController.playlistID = playlistID
//            controller?.present(nextViewController, animated:true, completion:nil)
            controller?.navigationController?.pushViewController(nextViewController, animated: true)
//            controller?.present(nextViewController, animated: true, completion: nil)
            //            nextViewController.presen
        }
        
    }
}
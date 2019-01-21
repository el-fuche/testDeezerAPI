//
//  PlaylistPresenter.swift
//  deezerPlaylistAPI
//
//  Created by Adadémey Marvin on 20/01/2019.
//  Copyright © 2019 Adadémey Marvin. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

class PlaylistPresenter {
    var playlists = [Playlist]()
    let disposeBag = DisposeBag()
    var controller : PlaylistViewController?
    
    /// To bind the presenter to the view controller
    ///
    /// - Parameter controllerToAttach: controller to bind
    func attachController(controllerToAttach:PlaylistViewController){
        self.controller = controllerToAttach
    }
    
    /// To return the title on the view controller
    ///
    /// - Returns: the title
    func getTitle()->String{
        return "Playlists"
    }
    
    func getAlert(){
        let alert = UIAlertController(title: nil, message: "No songs in this playlist yet.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        if let attachedController = controller{
            attachedController.present(alert, animated: true, completion: nil)
        }
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
    
    /// Get the playlist "the RX way"
    ///
    /// - Parameters:
    ///   - pid: deezer playlistID
    ///   - playlistArray: variable to store playlists
    func getRXPlaylist(pid:String,playlistArray:@escaping ([Playlist]?) -> ()){
        Manager.instance.getRxPlaylist(playlistID: pid)
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
    
    /// When a playlist is tapped
    ///
    /// - Parameter playlistID: Deezer playlist ID
    func goToSelectedPlaylist(playlistID:String){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SongsViewController") as? SongsViewController{
            nextViewController.playlistID = playlistID
            controller?.navigationController?.pushViewController(nextViewController, animated: true)
        }
        
    }
}

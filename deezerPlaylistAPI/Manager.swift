//
//  Manager.swift
//  deezerPlaylistAPI
//
//  Created by Adadémey Marvin on 20/01/2019.
//  Copyright © 2019 Adadémey Marvin. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift

class Manager: NSObject {
    enum GetFriendsFailureReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
    }
    
    static let instance = Manager()
    
    //MARK: - RX methods
    func getRxSongsFromPlaylist(playlistID:String)-> Observable<[Song]> {
        return Observable.create { observer -> Disposable in
            Alamofire.request("\(Constants.baseURL)/playlist/\(playlistID)/tracks", method: .get)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    
                    switch response.result{
                    case.success(let value):
                        let songs = self.setSongs(datas: (value as? [String:Any])!)
                        observer.onNext(songs)
                    case.failure(let error):
                        if let statusCode = response.response?.statusCode,
                            let reason = GetFriendsFailureReason(rawValue: statusCode)
                        {
                            observer.onError(reason)
                        }
                        observer.onError(error)
                    }
            }
            return Disposables.create()
            
        }
    }
    
    func getRxPlaylist(playlistID:String)-> Observable<[Playlist]> {
        return Observable.create { observer -> Disposable in
            Alamofire.request("\(Constants.baseURL)/user/\(playlistID)/playlists", method: .get)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    
                    switch response.result{
                    case.success(let value):
                        let plists = self.setPlaylists(datas: (value as? [String:Any])!)
                        observer.onNext(plists)
                    case.failure(let error):
                        if let statusCode = response.response?.statusCode,
                            let reason = GetFriendsFailureReason(rawValue: statusCode)
                        {
                            observer.onError(reason)
                        }
                        observer.onError(error)
                    }
            }
            return Disposables.create()
        }
    }
    
    //MARK: - "Classic" methods
    func getUserPlaylists(userID:String,datas: @escaping ([Playlist]?,Error?) -> ()){
        Alamofire.request("\(Constants.baseURL)/user/\(userID)/playlists", method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result{
                case.success(let value):
                    datas(self.setPlaylists(datas: (value as? [String:Any])!), nil)
                case.failure(let error):
                    datas(nil,error)
                }
        }
    }
    
    
    func getSongsFromPlaylist(playlistID:String,datas: @escaping ([Song]?,Error?) -> ()){
        Alamofire.request("\(Constants.baseURL)/playlist/\(playlistID)/tracks", method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
                switch response.result{
                case.success(let value):
                    datas(self.setSongs(datas: (value as? [String:Any])!), nil)
                case.failure(let error):
                    datas(nil,error)
                    
                }
        }
    }
    
    //MARK: - Set methods
    func setPlaylists(datas:[String:Any])->[Playlist]{
        var playlists = [Playlist]()
        let pl = datas["data"] as! [[String:Any]]
        for data in pl{
            print(data)
            if let picURL = data["picture"] as? String, let title = data["title"]as? String,let nb_tracks = data["nb_tracks"]as? Int, let creation_date = data["creation_date"]as? String,let owner = data["creator"] as? [String:Any],let identifiant = data["id"] as? NSNumber
            {
                let playlist = Playlist(pictureURL:picURL , title: title, numberOfSongs: nb_tracks, creationDate: creation_date, owner: owner["name"] as! String,id : "\(identifiant)")
                playlists.append(playlist)
                
            }
        }
        
        return playlists
    }
    
    func setSongs(datas:[String:Any])->[Song]{
        var songs = [Song]()
        let sgs = datas["data"] as! [[String:Any]]
        for data in sgs{
            print(data)
            if let title = data["title"] as? String, let duration = data["duration"]as? Int
            {
                let song = Song(duration: duration, title: title)
                songs.append(song)
            }
        }
        return songs
    }
    //MARK: - Other methods
    /// Get the time in readable format
    ///
    /// - Parameter totalVideoDuration: the duration of the song, in seconds
    /// - Returns: the duration, separated
    func getFormattedVideoTime(totalVideoDuration: Int) -> ( minutes: Int, seconds: Int){
        let seconds = totalVideoDuration % 60
        let minutes = (totalVideoDuration / 60) % 60
        return (minutes,seconds)
    }
}



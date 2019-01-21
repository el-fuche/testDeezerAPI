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
    
    func getRxPlaylist(userID:String)-> Observable<[Playlist]> {
        return Observable.create { observer -> Disposable in
            Alamofire.request("\(Constants.baseURL)/user/\(userID)/playlists", method: .get)
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
    
    func setPlaylists(datas:[String:Any])->[Playlist]{
        var playlists = [Playlist]()
        let pl = datas["data"] as! [[String:Any]]
        for data in pl{
            print(data)
            if let picURL = data["picture"] as? String, let title = data["title"]as? String,let nb_tracks = data["nb_tracks"]as? Int, let creation_date = data["creation_date"]as? String,let owner = data["creator"] as? [String:Any]{
                let playlist = Playlist(pictureURL:picURL , title: title, numberOfSongs: nb_tracks, creationDate: creation_date, owner: owner["name"] as! String)
                playlists.append(playlist)
                
            }
            //
            
        }
        
        return playlists
    }
}



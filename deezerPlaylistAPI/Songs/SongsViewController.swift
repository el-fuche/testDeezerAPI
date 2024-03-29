//
//  SongsViewController.swift
//  deezerPlaylistAPI
//
//  Created by Adadémey Marvin on 21/01/2019.
//  Copyright © 2019 Adadémey Marvin. All rights reserved.
//

import UIKit

class SongsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var playlistID:String?
    let tableView = UITableView()
    var presenter = SongsPresenter()
    var songs = [Song]()
    
    //MARK: - Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = presenter.getTitle()
        setTableView()
        if let pid = playlistID{
            getSongs(playlistID: pid)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table View delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = songs[indexPath.row].title
        let formattedTime = presenter.getFormattedTime(totalTime: songs[indexPath.row].duration)
        cell.detailTextLabel?.text = String("\(formattedTime.minutes) mn \(formattedTime.seconds)")
        return cell
    }
    
    //MARK: - Other methods
    func setTableView(){
        tableView.register(UINib(nibName: "SongTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.frame = self.view.frame
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    /// Methods to get sons from playlist
    ///
    /// - Parameter playlistID: deezer playlistID
    func getSongs(playlistID:String){
        if let pid = self.playlistID{
            presenter.getRXSongs(pid: pid, songsArray: { (songs) in
                if let receivedSongs = songs{
                    self.songs = receivedSongs
                    self.tableView.reloadData()
                }
            })
        }
        
        
    }
    
  
}

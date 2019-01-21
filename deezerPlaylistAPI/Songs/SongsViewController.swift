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
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        if let pid = playlistID{
            getSongs(playlistID: pid)
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //        cell.
        cell.textLabel?.text = songs[indexPath.row].title
        cell.detailTextLabel?.text = String(songs[indexPath.row].duration)
        //        cell.
        return cell
    }
    
    func setTableView(){
        tableView.register(UINib(nibName: "SongTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.frame = self.view.frame
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getSongs(playlistID:String){
        if let pid = self.playlistID{
            presenter.getSongs(playlistID: pid) { (songs) in
                if let receivedSongs = songs{
                    self.songs = receivedSongs
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

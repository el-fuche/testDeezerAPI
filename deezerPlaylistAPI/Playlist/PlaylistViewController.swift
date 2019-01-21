//
//  PlaylistViewController.swift
//  deezerPlaylistAPI
//
//  Created by Adadémey Marvin on 20/01/2019.
//  Copyright © 2019 Adadémey Marvin. All rights reserved.
//

import UIKit
import AlamofireImage

class PlaylistViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    @IBOutlet weak var userIDTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    var userID:String?
    var playlistID:String?
    var playlist = [Playlist]()
    var presenter = PlaylistPresenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        presenter.attachController(controllerToAttach: self)
    
//        presenter.getPlaylists(userId: Constants.MarvinID) { (datas) in
//            if let receivedPlaylists = datas{
//                self.playlist = receivedPlaylists
//                self.tableView.reloadData()
//            }
//        }
        getPlaylists(userID: Constants.MarvinID)
        self.userIDTextField.delegate = self
        self.userIDTextField.returnKeyType = .search
        self.userIDTextField.clearButtonMode = .unlessEditing
        self.userIDTextField.placeholder = "Enter user id"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.count
    }
    
    func setTableView(){
        tableView.register(UINib(nibName: "PlaylistTableViewCell", bundle: nil), forCellReuseIdentifier: "playlistCell")

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath) as! PlaylistTableViewCell
        cell.creationDate.text = playlist[indexPath.row].creationDate
        cell.numberOfSongs.text = String(playlist[indexPath.row].numberOfSongs)
        cell.playlistOwner.text = playlist[indexPath.row].owner
        cell.playlistTitle.text = playlist[indexPath.row].title
        cell.songID = String(playlist[indexPath.row].id)
        cell.playlistPic.af_setImage(withURL: URL(string:playlist[indexPath.row].pictureURL)!, placeholderImage: UIImage(named: "Placeholder"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedCell = tableView.cellForRow(at: indexPath) as? PlaylistTableViewCell{
            presenter.goToSelectedPlaylist(playlistID: selectedCell.songID!)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let selectedUserId = textField.text, selectedUserId.count > 0{
            userID = selectedUserId
            getPlaylists(userID: userID!)
            //Relancer l'url
        }
        else{
            getPlaylists(userID: Constants.MarvinID)
        }
        return true
    }
    
    func getPlaylists(userID:String){
        presenter.getRXPlaylist(uid: userID) { (datas) in
            if let receivedPlaylists = datas{
                self.playlist = receivedPlaylists
                self.tableView.reloadData()
            }
        }
        
//        presenter.getPlaylists(userId: userID) { (datas) in
//            if let receivedPlaylists = datas{
//                self.playlist = receivedPlaylists
//                self.tableView.reloadData()
//            }
//        }
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

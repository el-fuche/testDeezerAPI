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
    var tapGesture = UITapGestureRecognizer()

    
    //MARK: - Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = presenter.getTitle()

        setTableView()
        presenter.attachController(controllerToAttach: self)
        getPlaylists(userID: Constants.MarvinID)
        setTextField()

       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - Set TableView
    func setTableView(){
        tableView.register(UINib(nibName: "PlaylistTableViewCell", bundle: nil), forCellReuseIdentifier: "playlistCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - Table View delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.count
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath) as! PlaylistTableViewCell
        cell.creationDate.text = playlist[indexPath.row].creationDate
        cell.numberOfSongs.text = "\(String(playlist[indexPath.row].numberOfSongs)) songs"
        cell.playlistOwner.text = "By \(playlist[indexPath.row].owner)"
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
            if selectedCell.numberOfSongs.text != "0"{
                presenter.goToSelectedPlaylist(playlistID: selectedCell.songID!)
            }
            else{
                presenter.getAlert()
            }
        }
    }
    
    //MARK: - Textfield delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let selectedUserId = textField.text, selectedUserId.count > 0{
            userID = selectedUserId
            getPlaylists(userID: userID!)
        }
        else{
            getPlaylists(userID: Constants.MarvinID)
        }
        return true
    }
    
    //MARK: - Other methods
    /// To get thw playlist from a user
    ///
    /// - Parameter userID: Deezer userID
    func getPlaylists(userID:String){
        presenter.getRXPlaylist(pid: userID) { (datas) in
            if let receivedPlaylists = datas{
                self.playlist = receivedPlaylists
                self.tableView.reloadData()
            }
        }
    }
    
    func setTextField(){
        self.userIDTextField.delegate = self
        self.userIDTextField.returnKeyType = .search
        self.userIDTextField.clearButtonMode = .unlessEditing
        self.userIDTextField.placeholder = "Enter user id, mine by default"
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        userIDTextField.resignFirstResponder()
    }
}

//
//  PlaylistTableViewCell.swift
//  deezerPlaylistAPI
//
//  Created by Adadémey Marvin on 20/01/2019.
//  Copyright © 2019 Adadémey Marvin. All rights reserved.
//

import UIKit

class PlaylistTableViewCell: UITableViewCell {
    @IBOutlet weak var playlistTitle: UILabel!
    @IBOutlet weak var playlistOwner: UILabel!
    @IBOutlet weak var playlistPic: UIImageView!
    @IBOutlet weak var creationDate: UILabel!
    @IBOutlet weak var numberOfSongs: UILabel!
    var songID : String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

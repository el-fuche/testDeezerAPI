//
//  SongTableViewCell.swift
//  deezerPlaylistAPI
//
//  Created by Adadémey Marvin on 21/01/2019.
//  Copyright © 2019 Adadémey Marvin. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.detailTextLabel?.textColor = UIColor.lightGray
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

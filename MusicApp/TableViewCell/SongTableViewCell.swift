//
//  SongTableViewCell.swift
//  MusicApp
//
//  Created by Nero on 7/21/20.
//  Copyright © 2020 Nero. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    //MARK:Outlet
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblSong: UILabel!
    @IBOutlet weak var lblSinger: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func btnEdit(_ sender: Any) {
        
    }
}

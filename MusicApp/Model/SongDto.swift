//
//  SongDto.swift
//  MusicApp
//
//  Created by Nero on 7/21/20.
//  Copyright © 2020 Nero. All rights reserved.
//

import Foundation

struct SongDTO: Decodable {
    var id: Int = -1
    var name:String = ""
    var avatarName: String = ""
    var singer:String = ""
    var trackName: String = ""
    
//    init(id: Int, name: String, avatarName: String, singer: String, trackName: String){
//        self.id = id
//        self.name = name
//        self.avatarName = avatarName
//        self.singer = singer
//        self.trackName = trackName
//    }
}

struct SongRespone:Decodable {
    var respone: SongDTO
}

//
//  Manager.swift
//  MusicApp
//
//  Created by Nero on 7/30/20.
//  Copyright © 2020 Nero. All rights reserved.
//

import Foundation
import AVFoundation

public final class Manager{
    public static let shared = Manager()
    private var player: AVAudioPlayer?
    private var currentSong: SongDTO?
    var isPlaying: Bool {
        return player?.isPlaying ?? false
    }
    var volume: Float {
        return player?.volume ?? 0
    }
//    func shareMusic(){
//        player?.play()
//    }
    
    func playMusic(song: SongDTO) {
        if (currentSong?.id ?? -1) == song.id {
            play()
            return
        }
        currentSong = song
        player?.stop()
        
        do{
            let url = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
            guard let urlString = url else {
                return
            }
            try? AVAudioSession.sharedInstance().setMode(.default)
            //            try? AVAudioSession.sharedInstance().setCategory(.playback, options: [.defaultToSpeaker ,.allowAirPlay])
            try?AVAudioSession.sharedInstance().setCategory(.ambient)
            try? AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            
            guard let player =  player else {
                return
            }
            player.volume = 0.5
            player.play()
        }catch{
            NSLog(error.localizedDescription)
        }
    }
    
    func setVolume(_ value: Float) {
        player?.volume = value
    }
    
    func stop() {
        player?.stop()
    }
    
    func pause() {
        player?.pause()
    }
    
    func play() {
        player?.play()
    }
}

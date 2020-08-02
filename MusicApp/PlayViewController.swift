//
//  PlayViewController.swift
//  MusicApp
//
//  Created by Nero on 7/22/20.
//  Copyright © 2020 Nero. All rights reserved.
//
import AVFoundation
import UIKit

class PlayViewController: UIViewController, AVAudioPlayerDelegate {
    
    //MARK: Init
    public var position: Int = 0
    public var songs: [SongDTO] = []
    
    @IBOutlet weak var backGround: UIView!
    
//    var player: AVAudioPlayer?
    
    private let avatarImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
     }()
    
    private let singerNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
     }()
    
    let playBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if backGround.subviews.count == 0 {
            setUpPlayer()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
      
    //MARK:setup player
    func setUpPlayer(){
        
        let song = songs[position]
        Manager.shared.playMusic(song: song)
        
        //setup player cover
        avatarImageView.frame = CGRect(x: 10, y: 10, width: backGround.frame.size.width - 20, height: backGround.frame.size.width - 20)
        avatarImageView.image = UIImage(named: song.avatarName)
        
        songNameLabel.frame = CGRect(x: 10, y: avatarImageView.frame.size.height + 10, width: backGround.frame.size.width - 20, height: 70)
        songNameLabel.font = UIFont(name: "Helvetica-Bold", size: 18)
        singerNameLabel.frame = CGRect(x: 10, y: avatarImageView.frame.size.height + 10 + 30, width: backGround.frame.size.width - 20, height: 70)
        
        songNameLabel.text = song.name
        singerNameLabel.text = song.singer
        
        backGround.addSubview(avatarImageView)
        backGround.addSubview(songNameLabel)
        backGround.addSubview(singerNameLabel)
        
        //button Next, Backward, Pause, Play
        
        let nextBtn = UIButton()
        let backBtn = UIButton()
        
        let yPosition = singerNameLabel.frame.origin.y + 70
        let size:CGFloat = 70
        playBtn.frame = CGRect(x: (backGround.frame.size.width - size) / 2.0, y: yPosition, width: size, height: size)
        nextBtn.frame = CGRect(x: backGround.frame.size.width - size - 20, y: yPosition, width: size, height: size)
        backBtn.frame = CGRect(x: 20, y: yPosition, width: size, height: size)
        
        
        playBtn.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        nextBtn.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        playBtn.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        backBtn.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        nextBtn.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        playBtn.tintColor = .lightGray
        backBtn.tintColor = .cyan
        nextBtn.tintColor = .magenta

        backGround.addSubview(playBtn)
        backGround.addSubview(nextBtn)
        backGround.addSubview(backBtn)
        
        
        // Volume
        let slider = UISlider(frame: CGRect(x: 20, y: backGround.frame.size.height - 150, width: backGround.frame.size.height - 370, height: 50))
        slider.value = Manager.shared.volume
        slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        backGround.addSubview(slider)
    }
    
    func updateUI() {
        let song = songs[position]
        avatarImageView.image = UIImage(named: song.avatarName)
        songNameLabel.text = song.name
        singerNameLabel.text = song.singer
    }
    
    //MARK:Action
    
    @objc func didSlideSlider(_ slider: UISlider){
        let value = slider.value
        Manager.shared.setVolume(value)
    }
    
    @objc func didTapBackButton(){
        if position > 0{
            position = position - 1
            let song = songs[position]
            Manager.shared.playMusic(song: song)
            updateUI()
        }
    }
    
    @objc func didTapNextButton(){
        if position < (songs.count - 1){
            position = position + 1
             let song = songs[position]
             Manager.shared.playMusic(song: song)
            updateUI()
        }
    }
    
    @objc func didTapPlayButton(){
        if  Manager.shared.isPlaying == true {
             Manager.shared.pause()
            playBtn.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            UIView.animate(withDuration: 0.2, animations: {
                self.avatarImageView.frame = CGRect(x: 30, y: 30, width: self.backGround.frame.size.width - 70, height: self.backGround.frame.size.width - 70)
            })
        }else{
             Manager.shared.play()
            playBtn.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            UIView.animate(withDuration: 0.2, animations: {
                self.avatarImageView.frame = CGRect(x: 10, y: 10, width: self.backGround.frame.size.width - 20, height: self.backGround.frame.size.width - 20)
            })
        }
    }
}

//
//  ViewController.swift
//  MusicApp
//
//  Created by Nero on 7/21/20.
//  Copyright © 2020 Nero. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //MARK:Outlet
    @IBOutlet weak var tblSongView: UITableView!
    
    let songTableViewCell = "SongTableViewCell"
    var songs = [SongDTO]()
    var newSongs = [SongDTO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        tblSongView.register(UINib.init(nibName: songTableViewCell, bundle: nil), forCellReuseIdentifier: songTableViewCell)
        tblSongView.rowHeight = UITableView.automaticDimension
        tblSongView.separatorColor = UIColor.clear
    }
    
    func initData(){
        songs.append(SongDTO(id: 01, name: "Em muon ta la gi", avatarName: "Ava1", singer: "Thanh Hung", trackName: "song1"))
        songs.append(SongDTO(id: 02, name: "Hoa no khong mau(Acoustic)", avatarName: "Ava2", singer: "Hoai Lam", trackName: "song2"))
        songs.append(SongDTO(id: 03, name: "Mot Cu Lua", avatarName: "Ava3", singer: "Bich Phuong", trackName: "song3"))
        songs.append(SongDTO(id: 04, name: "Tu choi anh nhe nhang thoi", avatarName: "Ava4", singer: "Phuc du ft Bich Phuong", trackName: "song4"))
        songs.append(SongDTO(id: 05, name: "Em muon ta la gi", avatarName: "Ava1", singer: "Thanh Hung", trackName: "song1"))
        songs.append(SongDTO(id: 06, name: "Hoa no khong mau(Acoustic)", avatarName: "Ava2", singer: "Hoai Lam", trackName: "song2"))
        songs.append(SongDTO(id: 07, name: "Mot Cu Lua", avatarName: "Ava3", singer: "Bich Phuong", trackName: "song3"))
        songs.append(SongDTO(id: 08, name: "Tu choi anh nhe nhang thoi", avatarName: "Ava4", singer: "Phuc du ft Bich Phuong", trackName: "song4"))
        songs.append(SongDTO(id: 09, name: "Em muon ta la gi", avatarName: "Ava1", singer: "Thanh Hung", trackName: "song1"))
        songs.append(SongDTO(id: 10, name: "Hoa no khong mau(Acoustic)", avatarName: "Ava2", singer: "Hoai Lam", trackName: "song2"))
        songs.append(SongDTO(id: 11, name: "Mot Cu Lua", avatarName: "Ava3", singer: "Bich Phuong", trackName: "song3"))
        songs.append(SongDTO(id: 12, name: "Tu choi anh nhe nhang thoi", avatarName: "Ava4", singer: "Phuc du ft Bich Phuong", trackName: "song4"))
    }
        
    //TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let song = songs[indexPath.row]
//        let editAction = UITableViewRowAction(style: .default, title: "Edit Song") { (action, indexPath) in
//            self.updateSong(song: song, indexPath: indexPath)
//        }
//
//        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPtah) in
//            self.deleteSong(song: song, indexPath: indexPath)
//        }
//        deleteAction.backgroundColor = .red
//        editAction.backgroundColor = .green
//        return[deleteAction,editAction]
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let song = songs[indexPath.row]
        let actionEdit = UIContextualAction(style: .normal, title: "Edit") { (action, view, success) in
            let alert = UIAlertController(title: "Edit", message: "Edit Song", preferredStyle: .alert)
            alert.addTextField{(updateSongTF) in
                updateSongTF.placeholder = "Dien ten bai hat";
            }
            alert.addTextField{(updateImgSongTF) in
                updateImgSongTF.placeholder = "Dien ten avatar";
            }
            alert.addTextField{(updateSingerTF) in
                updateSingerTF.placeholder = "Dien ten ca sy";
            }
            alert.addTextField{(updateTrackTF) in
                updateTrackTF.placeholder = "Dien ten track";
            }
            let editAction = UIAlertAction(title: "Edit", style: .default) { (action) in
                guard let updateSongName = alert.textFields?.first else {
                    return
                }
                guard let updateAvatarSongName = alert.textFields?[1] else {
                    return
                }
                guard let updateSingerName = alert.textFields?[2] else {
                    return
                }
                guard let updateTrackName = alert.textFields?[3] else {
                    return
                }
                self.songs[indexPath.row].name = updateSongName.text ?? ""
                self.songs[indexPath.row].avatarName = updateAvatarSongName.text ?? ""
                self.songs[indexPath.row].singer = updateSingerName.text ?? ""
                self.songs[indexPath.row].trackName = updateTrackName.text ?? ""
                self.tblSongView.reloadData()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default)
            alert.addAction(editAction)
            alert.addAction(cancelAction)
            self.present(alert,animated: true)
        }
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            self.deleteSong(song: song, indexPath: indexPath)
        }
                actionDelete.backgroundColor = .red
                actionEdit.backgroundColor = .green
        return UISwipeActionsConfiguration(actions: [actionDelete, actionEdit])
    }
    
    private func deleteSong(song: SongDTO, indexPath: IndexPath){
        let alert = UIAlertController(title: "Delete Song", message: "Ban chac la muon xoa bai hat nay?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            self.songs.remove(at: indexPath.row)
            self.tblSongView.deleteRows(at: [indexPath], with: .automatic)
        }
        let cancel = UIAlertAction(title: "No", style: .default, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancel)
        present(alert,animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: songTableViewCell, for: indexPath) as! SongTableViewCell
        let song = songs[indexPath.row]
        cell.imgAvatar?.image = UIImage(named: song.avatarName)
        cell.lblSong?.text = song.name
        cell.lblSinger?.text = song.singer
        cell.accessoryType = .disclosureIndicator
        cell.lblSong?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.lblSinger?.font = UIFont(name: "Helvetica-Bold", size: 17)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let position = indexPath.row
        guard let vc = storyboard?.instantiateViewController(identifier: "player") as? PlayViewController else {
            return
        }
        vc.songs = songs
        vc.position = position
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: Action
    @IBAction func addSong(_ sender: Any) {
        let alert = UIAlertController(title:"Add Song", message: nil, preferredStyle: .alert)
        alert.addTextField{(songTF) in
            songTF.placeholder = "Enter song's name";
        }
        alert.addTextField{(imgSongTF) in
            imgSongTF.placeholder = "Enter avatar's name";
        }
        alert.addTextField{(singerTF) in
            singerTF.placeholder = "Enter singer's name";
        }
        alert.addTextField{(trackTF) in
            trackTF.placeholder = "Enter track's name";
        }
        let add = UIAlertAction(title: "Add", style: .default){ (_) in
            guard let newSongName = alert.textFields?.first?.text else {
                return
            }
            guard let newSongAvatarName  = alert.textFields?[1].text  else {
                return
            }
            guard let newSingerName = alert.textFields?[2].text else {
                return
            }
            guard let newTrackName = alert.textFields?[3].text else {
                return
            }
            
            let song = SongDTO(id: self.songs.count, name: newSongName, avatarName: newSongAvatarName, singer: newSingerName, trackName: newTrackName)
            self.songs.append(song)
            self.tblSongView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(add)
        alert.addAction(cancel)
        present(alert,animated: true)
    }
}

    


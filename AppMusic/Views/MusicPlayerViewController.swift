//
//  MusicPlayerViewController.swift
//  AppMusic
//
//  Created by Quang Khánh on 13/10/2022.
//

import UIKit

final class MusicPlayerViewController: UIViewController {

    var album: Album
    
    private lazy var mediaPlayer: MediaPlayer = {
        let viewMediaPlayer = MediaPlayer(album: album)
        view
    }

}

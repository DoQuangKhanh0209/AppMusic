//
//  MediaPlayerViewController.swift
//  AppMusic
//
//  Created by Quang Khánh on 13/10/2022.
//

import Foundation
import UIKit

final class MediaPlayerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBlurredView()
        setupView()
    }
    
    var album: Album
    
     init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addBlurredView()
        view.addSubview(mediaPlayer)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate ([
            mediaPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mediaPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mediaPlayer.topAnchor.constraint(equalTo: view.topAnchor),
            mediaPlayer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mediaPlayer.playMusic()
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        mediaPlayer.stopMusic()
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    private func addBlurredView() {
        if UIAccessibility.isReduceTransparencyEnabled {
            self.view.backgroundColor = UIColor.clear
                
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
            let blueEffectView = UIVisualEffectView(effect: blurEffect)
            blueEffectView.frame = self.view.bounds
            blueEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            
            view.addSubview(blueEffectView)
        } else {
            view.backgroundColor = UIColor.black
        }
    }
    
    private lazy var mediaPlayer: MediaPlayer = {
        let viewMediaPlayer = MediaPlayer(album: album)
        viewMediaPlayer.translatesAutoresizingMaskIntoConstraints = false
        return viewMediaPlayer
    }()
    
}

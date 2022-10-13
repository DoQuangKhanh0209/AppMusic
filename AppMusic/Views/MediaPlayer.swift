//
//  MediaPlayer.swift
//  AppMusic
//
//  Created by Quang Khánh on 12/10/2022.
//

import Foundation
import UIKit
import AVKit

class MediaPlayer: UIView {
    
    var album: Album
    
    private var player = AVAudioPlayer()
    private var timer: Timer?
    private var playingIndex = 0
    
    init(album: Album) {
        self.album = album
        super.init(frame: .zero)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        albumName.text = album.name
        albumCover.image = UIImage(named: album.image)
        //call setup player and with the first song
        setupPlayer(song: album.songs[playingIndex])
        
        [albumName, songNameLabel, artistSongLabel, elapsedTimeLabel, remainingTimeLabel].forEach { (v) in            v.textColor = .white
        }
        
        [albumName, albumCover, songNameLabel, artistSongLabel, progessBar, elapsedTimeLabel, remainingTimeLabel, controlStack].forEach { (v) in
            addSubview(v)
        }
        
        setupConstraints()
    }
    
    //setup player
    private func setupPlayer(song: Song) {
        guard let url = Bundle.main.url(forResource: song.fileName, withExtension: "mp3") else {
            return
        }
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        }
        
        songNameLabel.text = song.name
        artistSongLabel.text = song.artist
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.delegate = self
            player.prepareToPlay()
            
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // name album
    private lazy var albumName: UILabel = {
        let viewLabelAlbumName = UILabel()
        viewLabelAlbumName.translatesAutoresizingMaskIntoConstraints = false
        viewLabelAlbumName.textAlignment = .center
        viewLabelAlbumName.font = .systemFont(ofSize: 32, weight: .bold)
        return viewLabelAlbumName
    }()
    
    // image cover
    private lazy var albumCover: UIImageView = {
        let viewImageAlbumCover = UIImageView()
        viewImageAlbumCover.translatesAutoresizingMaskIntoConstraints = false
        viewImageAlbumCover.contentMode = .scaleAspectFit
        viewImageAlbumCover.clipsToBounds = true
        viewImageAlbumCover.layer.cornerRadius = 100
        viewImageAlbumCover.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        return viewImageAlbumCover
    }()
    
    // progess bar music
    private lazy var progessBar: UISlider = {
        let viewProgessBar = UISlider()
        viewProgessBar.translatesAutoresizingMaskIntoConstraints = false
        viewProgessBar.addTarget(self, action: #selector(progressScrubbed(_:)), for: .valueChanged)
        return viewProgessBar
    }()
    
    // song name
    private lazy var songNameLabel: UILabel = {
        let viewSongNameLabel = UILabel()
        viewSongNameLabel.translatesAutoresizingMaskIntoConstraints = false
        viewSongNameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        return viewSongNameLabel
    }()
    
    //song artist
    private lazy var artistSongLabel: UILabel = {
        let viewArtistSongLabel = UILabel()
        viewArtistSongLabel.translatesAutoresizingMaskIntoConstraints = false
        viewArtistSongLabel.font = .systemFont(ofSize: 16, weight: .light)
        return viewArtistSongLabel
    }()
    
    //update time elapsed in label
    private lazy var elapsedTimeLabel: UILabel = {
        let viewElapsedTimeLabel = UILabel()
        viewElapsedTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        viewElapsedTimeLabel.text = "00.00"
        viewElapsedTimeLabel.font = .systemFont(ofSize: 14, weight: .light)
        return viewElapsedTimeLabel
    }()
    
    //update time remaining in label
    private lazy var remainingTimeLabel: UILabel = {
        let viewRemainingTimeLabel = UILabel()
        viewRemainingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        viewRemainingTimeLabel.text = "00.00"
        viewRemainingTimeLabel.font = .systemFont(ofSize: 14, weight: .light)
        return viewRemainingTimeLabel
    }()
    
    // previous music
    private lazy var previousButton: UIButton = {
        let viewPreviousButton = UIButton()
        viewPreviousButton.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 38)
        viewPreviousButton.tintColor = .white
        viewPreviousButton.setImage(UIImage(systemName: "backward.end.fill", withConfiguration: config), for: .normal)
        viewPreviousButton.addTarget(self, action: #selector(didTabProvious(_:)), for: .touchUpInside)
        return viewPreviousButton
    }()
    
    //play and pause music
    private lazy var playPauseButton: UIButton = {
        let viewplayPauseButton = UIButton()
        viewplayPauseButton.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 100)
        viewplayPauseButton.tintColor = .white
        viewplayPauseButton.setImage(UIImage(systemName: "play.circle.fill", withConfiguration: config), for: .normal)
        viewplayPauseButton.addTarget(self, action: #selector(didTabPlayPause(_:)), for: .touchUpInside)
        return viewplayPauseButton
    }()
    
    //next music
    private lazy var nextButton: UIButton = {
        let viewNextButton = UIButton()
        viewNextButton.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 38)
        viewNextButton.tintColor = .white
        viewNextButton.setImage(UIImage(systemName: "forward.end.fill", withConfiguration: config), for: .normal)
        viewNextButton.addTarget(self, action: #selector(didTabNext(_:)), for: .touchUpInside)
        return viewNextButton
    }()
    
    //stack button play, provious, next music
    private lazy var controlStack: UIStackView = {
        let viewStackButton = UIStackView(arrangedSubviews: [previousButton, playPauseButton, nextButton])
        viewStackButton.translatesAutoresizingMaskIntoConstraints = false
        viewStackButton.axis = .horizontal
        viewStackButton.distribution = .equalSpacing
        viewStackButton.spacing = 20
        return viewStackButton
    }()
    
    private func setupConstraints() {
        //setup name
        NSLayoutConstraint.activate([
            albumName.leadingAnchor.constraint(equalTo: leadingAnchor),
            albumName.trailingAnchor.constraint(equalTo: trailingAnchor),
            albumName.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        ])
        
        //setup cover
        NSLayoutConstraint.activate([
            albumCover.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            albumCover.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            albumCover.topAnchor.constraint(equalTo: albumName.bottomAnchor, constant: 32),
            albumCover.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.5)
        ])
        
        //setup song name
        NSLayoutConstraint.activate([
            songNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            songNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            songNameLabel.topAnchor.constraint(equalTo: albumCover.bottomAnchor, constant: 16)
        ])
        
        //setup artist label
        NSLayoutConstraint.activate([
            artistSongLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            artistSongLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            artistSongLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 8)
        ])
        
        //setup progress bar
        NSLayoutConstraint.activate([
            progessBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            progessBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            progessBar.topAnchor.constraint(equalTo: artistSongLabel.bottomAnchor, constant: 8)
        ])
        
        //setup elapsed time
        NSLayoutConstraint.activate([
            elapsedTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            elapsedTimeLabel.topAnchor.constraint(equalTo: progessBar.bottomAnchor, constant: 8)
        ])
        
        //setup remaining time
        NSLayoutConstraint.activate([
            remainingTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            remainingTimeLabel.topAnchor.constraint(equalTo: progessBar.bottomAnchor, constant: 8)
        ])
        
        //control stack
        NSLayoutConstraint.activate([
            controlStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            controlStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            controlStack.topAnchor.constraint(equalTo: remainingTimeLabel.bottomAnchor, constant: 8)
        ])
    }
    
    func playMusic() {
        progessBar.value = 0.0
        progessBar.maximumValue = Float(player.duration)
        player.play()
        setPlayPauseIcon(isPlaying: player.isPlaying)
        
    }
    
    func stopMusic() {
        player.stop()
        timer?.invalidate()
        timer = nil
    }
    
    private func setPlayPauseIcon(isPlaying: Bool) {
        let config = UIImage.SymbolConfiguration(pointSize: 100)
        playPauseButton.setImage(UIImage(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill",withConfiguration: config), for: .normal)
    }

    
    @objc private func updateProgress(_ sender: UISlider) {
        progessBar.value = Float(player.currentTime)
        
        elapsedTimeLabel.text = getFormattedTime(timeInterval: player.currentTime)
        let remainingTime = player.duration - player.currentTime
        remainingTimeLabel.text = getFormattedTime(timeInterval: remainingTime)
    }
    
    @objc private func progressScrubbed(_ sender: UISlider) {
        player.currentTime = Float64(sender.value)
    }
    
    @objc private func didTabProvious(_ sender: UIButton) {
        playingIndex -= 1
        if playingIndex < 0 {
            playingIndex = album.songs.count - 1
        }
        setupPlayer(song: album.songs[playingIndex])
        playMusic()
        setPlayPauseIcon(isPlaying: player.isPlaying)
    }
    
    @objc private func didTabPlayPause(_ sender: UIButton) {
        if player.isPlaying {
            player.pause()
        } else {
            player.pause()
        }
        
        setPlayPauseIcon(isPlaying: player.isPlaying)
    }
    
    @objc private func didTabNext(_ sender: UIButton) {
        playingIndex += 1
        if playingIndex >= album.songs.count {
            playingIndex = 0
        }
        setupPlayer(song: album.songs[playingIndex])
        playMusic()
        setPlayPauseIcon(isPlaying: player.isPlaying)
    }
    
    private func getFormattedTime(timeInterval: TimeInterval) -> String {
        let mins = timeInterval / 60
        let secs = timeInterval.truncatingRemainder(dividingBy: 60)
        let timeFormatter = NumberFormatter()
        timeFormatter.minimumIntegerDigits = 2
        timeFormatter.minimumFractionDigits = 0
        timeFormatter.roundingMode = .down
        
        
        guard let minsString = timeFormatter.string(from: NSNumber(value: mins)),
              let secStr = timeFormatter.string(from: NSNumber(value: secs)) else {
            return "00.00"
        }
        
        return "\(minsString):\(secStr)"
    }
    
}

extension MediaPlayer: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        didTabNext(nextButton)
    }
}

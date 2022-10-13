//
//  AlbumTableViewCell.swift
//  AppMusic
//
//  Created by Quang Khánh on 11/10/2022.
//

import UIKit

final class AlbumTableViewCell: UITableViewCell {
    var album: Album? {
        didSet {
            if let album = album {
                albumCover.image = UIImage(named: album.image)
                albumName.text = album.name
                songsCount.text = "\(album.songs.count) Songs"
            }
        }
    }
    
    private lazy var albumCover: UIImageView = {
        let viewAlbumCover = UIImageView()
        viewAlbumCover.translatesAutoresizingMaskIntoConstraints = false
        viewAlbumCover.contentMode = .scaleToFill
        viewAlbumCover.clipsToBounds = true
        viewAlbumCover.layer.cornerRadius = 25
        viewAlbumCover.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        return viewAlbumCover
    }()
    
    private lazy var albumName: UILabel = {
        let viewAlbumName = UILabel()
        viewAlbumName.translatesAutoresizingMaskIntoConstraints = false
        viewAlbumName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        viewAlbumName.textColor = UIColor(named: "titleColor")
        return viewAlbumName
    }()
    
    private lazy var songsCount: UILabel = {
        let viewSongsCount = UILabel()
        viewSongsCount.translatesAutoresizingMaskIntoConstraints = false
        viewSongsCount.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        viewSongsCount.textColor = .darkGray
        viewSongsCount.numberOfLines = 0
        viewSongsCount.textColor = UIColor(named: "subtitleColor")
        return viewSongsCount
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [albumCover, albumName, songsCount].forEach{ (v) in
            contentView.addSubview(v)
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        //constraint album cover
        NSLayoutConstraint.activate([
            albumCover.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            albumCover.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            albumCover.widthAnchor.constraint(equalToConstant: 100),
            albumCover.heightAnchor.constraint(equalToConstant: 100),
            albumCover.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        ])
        
        //constraint name
        NSLayoutConstraint.activate([
            albumName.leadingAnchor.constraint(equalTo: albumCover.trailingAnchor, constant: 16),
            albumName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            albumName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
        ])
        
        //constraint songs count
        NSLayoutConstraint.activate([
            songsCount.leadingAnchor.constraint(equalTo: albumCover.trailingAnchor, constant: 16),
            songsCount.topAnchor.constraint(equalTo: albumName.bottomAnchor, constant: 0),
            songsCount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            songsCount.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}

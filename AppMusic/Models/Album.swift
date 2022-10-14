//
//  Album.swift
//  AppMusic
//
//  Created by Quang Khánh on 11/10/2022.
//

import Foundation

struct Album {
  var name: String
  var image: String
  var songs: [Song]
}

extension Album {
  static func get() -> [Album] {
    return [
      Album(name: "Acoustic", image: "acoustic", songs: [
        Song(name: "Acoustic Breeze", image: "acoustic", artist: "Bendsound.com", fileName: "audio"),
        Song(name: "Acoustic Breeze", image: "acoustic", artist: "Bendsound.com", fileName: "audio"),
        Song(name: "Acoustic Breeze", image: "acoustic", artist: "Bendsound.com", fileName: "audio")
      ]),
      Album(name: "Cinematic", image: "cinematic", songs: [
        Song(name: "Cinematic Breeze", image: "cinematic", artist: "Bendsound.com", fileName: "audio"),
        Song(name: "Cinematic Breeze", image: "cinematic", artist: "Bendsound.com", fileName: "audio"),
        Song(name: "Cinematic Breeze", image: "cinematic", artist: "Bendsound.com", fileName: "audio")
      ]),
      Album(name: "Jazz", image: "jazz", songs: [
        Song(name: "Jazz Breeze", image: "jazz", artist: "Bendsound.com", fileName: "audio"),
        Song(name: "Jazz Breeze", image: "jazz", artist: "Bendsound.com", fileName: "audio"),
        Song(name: "Jazz Breeze", image: "jazz", artist: "Bendsound.com", fileName: "audio")
      ])
    ]
  }
}

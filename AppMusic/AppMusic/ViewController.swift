//
//  ViewController.swift
//  AppMusic
//
//  Created by Quang Khánh on 10/10/2022.
//

import UIKit

final class ViewController: UIViewController {
  
  let albums = Album.get()
  
  //table view album list
  private lazy var tableView: UITableView = {
    let v = UITableView()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.delegate = self
    v.dataSource = self
    v.register(AlbumTableViewCell.self, forCellReuseIdentifier: "cell")
    v.rowHeight = UITableView.automaticDimension
    v.tableFooterView = UIView()
    return v
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    
  }
  private func setupView() {
    title = "My Music Player"
    view.addSubview(tableView)
    
    setupConstraints()
  }
  private func setupConstraints() {
    //constraints table view
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return albums.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AlbumTableViewCell else {
      return UITableViewCell()
    }
    cell.album = albums[indexPath.row]
    return cell
  }
}

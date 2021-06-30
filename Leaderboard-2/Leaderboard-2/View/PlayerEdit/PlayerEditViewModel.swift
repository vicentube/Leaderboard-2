// PlayerEditViewModel.swift
// Leaderboard-2
//
// Creado el 30/6/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

final class PlayerEditViewModel: ObservableObject {
  
  @Published var player: Player
  var playerChanged: ((Player) -> Void)
  
  @Published var pickedImage: UIImage? = nil
  @Published var playerPicture: UIImage? = nil
  @Published var showingImagePicker = false
  
  init(player: Player, onPlayerChanged: @escaping (Player) -> Void) {
    self.player = player
    self.playerChanged = onPlayerChanged
  }
  
  func showImagePicker() {
    showingImagePicker = true
  }
  
  func onDoneTap() {
    if let playerPicture = playerPicture {
      player.savePicture(playerPicture)
    }
    playerChanged(player)
  }
  
  func onDismissImagePicker() {
    if let picture = pickedImage {
      playerPicture = picture
      pickedImage = nil
    }
  }
}

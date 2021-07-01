// PlayerEditViewModel.swift
// Leaderboard-2
//
// Creado el 30/6/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Combine
import UIKit.UIImage

final class PlayerEditViewModel: ObservableObject {
  private let model: LeaderboardModel = .shared
  private var cancellable: AnyCancellable?
  
  @Published var player: Player
  @Published var pickedImage: UIImage? = nil
  @Published var playerPicture: UIImage? = nil
  
  var closeView: (() -> Void)!
  
  init(player: Player) {
    self.player = player
    // subscribe to model changes to notify the view
    self.cancellable = model.objectWillChange.sink { [weak self] in
      self?.objectWillChange.send()
    }
  }
  
  func saveAndClose() {
    // update player if picture has changed
    if let playerPicture = playerPicture {
      player.savePicture(playerPicture)
    }
    // persist player and close the view
    model.savePlayer(player)
    closeView()
  }
  
  func onDismissImagePicker() {
    if let picture = pickedImage {
      playerPicture = picture
      pickedImage = nil
    }
  }
}

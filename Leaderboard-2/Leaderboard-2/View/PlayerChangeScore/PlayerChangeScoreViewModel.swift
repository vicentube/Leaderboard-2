// PlayerChangeScoreViewModel.swift
// Leaderboard-2
//
// Creado el 30/6/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

final class PlayerChangeScoreViewModel: ObservableObject {
  @Published var player: Player
  var playerChanged: (Player) -> Void
  
  @Published var newScoreText = ""
  
  init(player: Player, onPlayerChanged: @escaping (Player) -> Void) {
    self.player = player
    self.playerChanged = onPlayerChanged
  }
  
  func onDoneTap() {
    if let newScore = Int(newScoreText) {
      player.score = newScore
      playerChanged(player)
    } else {
      newScoreText = ""
    }
  }
}
